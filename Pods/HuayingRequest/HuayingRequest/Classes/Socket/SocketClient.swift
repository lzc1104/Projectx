//
//  SocketClient.swift
//  Pods
//
//  Created by lzc1104 on 2017/9/14.
//
//

import Foundation
import SwiftWebSocket
import Alamofire


public class SocketDelegate {
    init() {
        
    }
}

public class SocketClient {
    
    public enum ConnectState {
        case connected
        case disconnected
        case connecting
    }
    
    public enum DisconnectedReason {
        case force
        case unstableNetwork
    }
    
    ///MARK: - Private property
    private var webSocket: WebSocket
    private var reachablity: NetworkReachabilityManager
    private var dataBuffer: [Data]
    private var pendingQueue: DispatchQueue
    private var pendingSemaphore: DispatchSemaphore
    private var reconnectManager: ReconnectManager
    private var address: URL
    ///MARK: - Hook
    public typealias DataHandler = ((Data) -> Void)
    public typealias StatusHandler = ((ConnectState) -> Void)
    public var didReceiveData: DataHandler?
    public var didChangeStatus: StatusHandler?
    
    ///MARK: - Public properties
    public var connectStatus: ConnectState
    public var isEnableBuffer: Bool = true
    public var isEnableAutoReconnect: Bool = true
    public var isEnablelog: Bool = true
    
    public convenience init(url: URL , protocols: [String]) {
        let reconnectManager = ReconnectManager(type: ReconnectManager.ReconnectType.fixed(5))
        self.init(url: url, protocols: protocols, reconnectManager: reconnectManager)
    }
    
    public init(url: URL , protocols: [String] , reconnectManager: ReconnectManager) {
        self.dataBuffer = []
        self.address = url
        self.webSocket = WebSocket.init(url: url)
        self.reachablity = NetworkReachabilityManager()!
        self.connectStatus = .disconnected
        self.pendingQueue = DispatchQueue(label: "com.huayingRequest.socket.data")
        self.pendingSemaphore = DispatchSemaphore(value: 1)
        self.reconnectManager = reconnectManager
        self.setupEvent()
        
    }
    
    
    private func setupEvent() {
        
        self.webSocket.event.message = { [unowned self] message in
            
            if let data = message as? [UInt8] {
                let datas = Data.init(bytes: data)
                self.didReceiveData?(datas)
            }
        }
        
        self.webSocket.event.error = { [unowned self]  error in

            self.connectStatus = .disconnected
            self.didChangeStatus?(.disconnected)
            
            if self.isEnableAutoReconnect {
                self.reconnectManager.beginReconnect()
                DPrint("[SocketClient] : Will try reconnect to server \(self.address.absoluteString) , in \(self.reconnectManager.delaySeconds) seconds")
            }
        }
        
        self.webSocket.event.open = { [unowned self]  in
            self.connectStatus = .connected
            self.didChangeStatus?(.connected)
            self.reconnectManager.stopReconnect()
            if self.isEnableBuffer {
                self.resumeUnsendData()
            }
        }
 
        self.reachablity.listener = { [unowned self] status in
            
            if  case .reachable(_) = status,
                self.connectStatus ~= .disconnected,
                self.isEnableAutoReconnect {
                self.connect()
            }
        }
        
        self.reconnectManager.tryReconnect = { [unowned self] times in
            if !self.isEnableAutoReconnect { return }
            if !self.reachablity.isReachable {
                DPrint("[SocketClient] : Will try reconnect when become network reachable in \(self.reconnectManager.delaySeconds) seconds ")
                return
            }
            if self.connectStatus == .connecting {
                /// 待连接断开后再执行
                self.reconnectManager.stopReconnect()
                return
            }
            
            self.connect()
        }
        
        self.reachablity.startListening()
        
        
    }
    
    public func connect() {
        switch self.connectStatus {
        case .connected,.connecting:
            return
        case .disconnected:
            self.webSocket.open()
            self.connectStatus = .connecting
            self.didChangeStatus?(.connecting)
        }
    }
    
    public func disconnect() {
        switch self.connectStatus {
        case .connected,.connecting:
            self.webSocket.close()
        case .disconnected:
            return
            
        }
    }
    
    public func write(data: Data) {
        
        self.syncSending { [unowned self] in
            guard self.webSocket.readyState == .open else {
                self.dataBuffer += [data]
                return
            }
            self.webSocket.send(data: data)
            let str = "[SocketClient]: Did send data to server: \(self.address.absoluteString)"
            DPrint(str)
        }
    }
    
    private func resumeUnsendData() {
        self.dataBuffer.forEach {
            self.write(data: $0)
        }
        self.dataBuffer = []
    }
    
    private func syncSending(_ operation: () -> Void) {
        self.pendingSemaphore.wait()
        operation()
        self.pendingSemaphore.signal()
    }
    
    deinit {
        self.reachablity.listener = nil
        self.reconnectManager.tryReconnect = nil
        self.webSocket.event.error = { _ in }
        self.webSocket.event.open = { _ in }
        self.webSocket.event.message = { _ in }
        DPrint("[SocketClient Event] deinit")
    }
    
}


func DPrint(_ items: Any...) {
    #if DEBUG
    print(items)
    #endif
}


