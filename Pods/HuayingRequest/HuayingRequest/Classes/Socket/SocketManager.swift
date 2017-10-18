//
//  SocketManager.swift
//  Pods
//
//  Created by lzc1104 on 2017/9/15.
//
//

import Foundation
import Protobuf
import Alamofire


/*
  Features:
  1.心跳机制 - 超时心跳自动重连服务器
  2.socket 消息模拟HTTP应答机制
  3.socket 消息超时检测
  4.socket 自动重连机制
  5.socket 消息包语义正确性
  6.心跳包和业务消息包队列分离 -- //TODO
 */

/// Websocket 管理器
public protocol Disposeable {
    func dispose()
}

public struct Disposeables: Disposeable {
    public func dispose() {
        
    }
}

/// 加密设施
public struct EncryptService {
    /// 解密套件
    public var decryptor: Decryptor
    /// 加密套件
    public var encryptor: Encryptor
    /// 公私钥集合 - 用于寻找解密key
    public var keySet: Set<KeyChainStore> = []
    /// 正在使用的加密公私钥
    public var encryptKeyStore: KeyChainStore?
    
    public init(keySet: Set<KeyChainStore> , store: KeyChainStore?) {
        self.decryptor = XXTEADecryptor()
        self.encryptor = XXTEAEncryptor()
        self.encryptKeyStore = store
        self.keySet = keySet
    }
    
    public init() {
        self.init(keySet: [], store: KeyChainStore(publicKey: "", privateKey: ""))
    }
}


public class WebSocketManager {
    
    public enum ConnectState {
        case connected
        case disconnected
        case connecting
        
    }
    
    public enum TokenStatus {
        case signined(String)
        case notYet
    }
    
    private enum SendingStatus {
        case pending(SocketRawRequest)
        case free
    }
    ///MARK: - Private properties
    public typealias HeartBeatManager = ReconnectManager
    public typealias ExpireBeatManager = ReconnectManager
    
    private var currentPendingState: SendingStatus = .free
    private var client: SocketClient?
    private var address: URL
    private var heartBeatManager: HeartBeatManager
    private var expireBeatManager: ExpireBeatManager
    private var pingQueue: DispatchQueue
    private var messageQueue: DispatchQueue
    private var deviceInfo: DeviceInfo?
    private var networkInfo: NetworkInfo?
    
    private var messageBuffer: [SocketRawRequest] = []
    
    private static let dataQueue: DispatchQueue = DispatchQueue(label: "com.huayingRequest.websocket.dataQueue")
    
    private var socketSet: [UInt64: SocketRawRequest] = [:]
    
    ///MARK: - Hook
    public var publishDataHandler: ((Data,UInt32) -> Void)?
    public var statusHandler: ((ConnectState) -> Void)?
    
    public var encryptService: EncryptService?
    
    ///MARK: - Public properties
    public var tokenStatus: TokenStatus = .notYet
    public var connectStatus: ConnectState {
        guard let client = self.client else {
            return .disconnected
        }
        if client.connectStatus == .connecting { return .connecting }
        if client.connectStatus == .connected { return .connected }
        return .disconnected
    }
    
    public convenience init(
        address: URL,
        deviceInfo: DeviceInfo? = nil,
        networkInfo: NetworkInfo? = nil) {
        self.init(address: address,encryptService: nil,deviceInfo: deviceInfo,networkInfo: networkInfo)
    }
    
    public convenience init(
        address: URL,
        encryptService: EncryptService?,
        deviceInfo: DeviceInfo? = nil,
        networkInfo: NetworkInfo? = nil) {
        
        let heartBeatManager = HeartBeatManager(type: .fixed(30))
        let expireBeatManager = ExpireBeatManager(type: .fixed(1))
        self.init(address: address,
                  encryptService: encryptService,
                  heartBeatManager: heartBeatManager,
                  expireBeatManager: expireBeatManager,
                  deviceInfo: deviceInfo,
                  networkInfo: networkInfo)
    }
    
    public init(
        address: URL,
        encryptService: EncryptService?,
        heartBeatManager: HeartBeatManager,
        expireBeatManager: ExpireBeatManager,
        deviceInfo: DeviceInfo?,
        networkInfo: NetworkInfo?) {
        let pingUUID = UUID().uuidString
        let messageQueueUUID = UUID().uuidString
        self.address = address
        self.encryptService = encryptService
        self.heartBeatManager = heartBeatManager
        self.expireBeatManager = expireBeatManager
        self.deviceInfo = deviceInfo
        self.networkInfo = networkInfo
        self.pingQueue = DispatchQueue(label: "com.huayingRequest.websocket.pingQueue\(pingUUID)", qos: .background)
        self.messageQueue = DispatchQueue(label: "com.huayingRequest.websocket.messageQueue\(messageQueueUUID)")
        self.setup()
        
    }
    
    ///MARK: - Public Api
    @discardableResult
    public func sendSocketMessage<R: GPBMessage>(_ message: GPBMessage? , type: Int32 , callback: ((Result<R?>) -> Void)?) -> Disposeable {
        
        if Int32(type) == PBMessageType.socketPingPong.rawValue {
            self.sendPing()
            return Disposeables()
        }
        
        let socketMessge = self.socketMessageTemplate(message, type: type)
        let request = SocketRequest(message: socketMessge, body: message, callback: callback)
        self.socketSet[socketMessge.requestId] = request
        self.messageBuffer += [request]
        (self.messageBuffer , self.currentPendingState) = self.dequeueSend(buffer: self.messageBuffer)
        return request
    }
    public func beginHeartBeat() {
        self.heartBeatManager.beginReconnect()
    }
    
    public func stopHeartBeat() {
        self.heartBeatManager.stopReconnect()
    }
    
    public func sendPing() {
        
        guard let client = self.client else {
            return
        }
        guard client.connectStatus == .connected else {
            return
        }
        let pingTemplate = self.pingSocketMessageTemplate()
        let request = SocketRequest(message: pingTemplate, body: nil) { ( result: Result<GPBMessage?>) in
            if case .failure(let error) = result {
            /// 心跳超时或者失败
                DPrint("[SocketManager]: generate error \(error)")
                self.disconnect()
                self.connect()
                return 
            }
            
            /// 心跳成功
            DPrint("[SocketManager]: Heart beat to server: \(self.address.absoluteString) still alive")
        }
        self.socketSet[pingTemplate.requestId] = request
        
        self.pingQueue.sync {
            client.write(data: request.datas())
        }
    }
    
    public func connect() {
        self.disconnect()
        self.client = self.buildClientTemplate()
        self.client?.connect()
        
    }
    
    public func disconnect() {
        self.client?.disconnect()
        self.client = nil
    }
    
    ///MARK:- Private methods
    private func setup() {
        
        /// 定时清理
        self.expireBeatManager.tryReconnect = { [unowned self] _ in
            
            let currentTimestamp: UInt64 = UInt64(Date().timeIntervalSince1970 * 1000)
            var toRemoveRequest: [SocketRawRequest] = []
            
            /// 找出所有超时的请求
            toRemoveRequest = self.socketSet.map({ (key,value) -> SocketRawRequest? in
                let requestTime = value.timeStamp()
                let diff = currentTimestamp - requestTime
                if diff > 30 * 1000 { return value }
                else { return nil }
            }).flatMap{ $0 }
            
            guard !toRemoveRequest.isEmpty else {
                return
            }
            
            /// 移除在发送的缓冲区的请求
            var buffers = self.messageBuffer
            toRemoveRequest.map{ $0.requestId() }.forEach{ self.socketSet[$0] = nil }
            buffers = toRemoveRequest.reduce(self.messageBuffer, { (oldBuffers, request) -> [SocketRawRequest] in
                var updateBuffers = oldBuffers
                if let index = updateBuffers.index(where: { $0 == request }) {
                    updateBuffers.remove(at: index)
                }
                return updateBuffers
            })
            self.messageBuffer = buffers
            
            
            /// 超时回调
            let error = NSError.huayingError(description: "网络不好请重新发送")
            toRemoveRequest.forEach{ $0.didReceiveError(error) }
            toRemoveRequest.forEach{ self.socketSet[$0.requestId()] = nil }
            
        }
        self.expireBeatManager.beginReconnect()
        /// 心跳
        self.heartBeatManager.tryReconnect = {[unowned self] _ in
            self.sendPing()
        }
        
    }
    
    private func dequeueSend(buffer: [SocketRawRequest]) -> ([SocketRawRequest],SendingStatus) {
        guard !buffer.isEmpty else {
            return ([],.free)
        }
        let request = buffer.first!
        switch self.currentPendingState {
        case .pending(let req):
            /// 发送中，还没回调-- 语义正确性
            return (buffer, SendingStatus.pending(req))
        case .free:
            guard let client = self.client else {
                return (buffer, .free)
            }
            
            guard client.connectStatus == .connected else {
                return (buffer, .free)
            }
            self.messageQueue.sync {
                self.client?.write(data: request.datas())
            }
            var updateBuffer = buffer
            let currentRequest = updateBuffer.removeFirst()
            return (updateBuffer,SendingStatus.pending(currentRequest))
        }
    }
    
    private func buildClientTemplate() -> SocketClient {
        let client = SocketClient(url: self.address, protocols: [""])
            /// 收到消息包
        client.didReceiveData = { [unowned self] data in
            guard let message = self.parseData(data) else { return }
            print("[SocketMessage]: Receive SocketMessage :\(message)")
            guard message.ack else {
            /// 广播报文
                let bussinessData: Data
                do {
                    
                    bussinessData = try self.decryptDataIfNeed(message, decryptor: self.encryptService?.decryptor)
                    
                } catch let e {
                    DPrint("[SocketParse]: \(e)")
                    return
                }
                let type = message.type
                self.publishDataHandler?(bussinessData,type)
                return
            }
            /// 串行继续发送
            defer {
                
                self.currentPendingState = .free
                (self.messageBuffer,self.currentPendingState) = self.dequeueSend(buffer: self.messageBuffer)
                
                
            }
            /// 超时已经被清除
            guard let request = self.socketSet[message.requestId] else {
                
                return
            }
            /// 应答报文
            defer {
                if Int32(message.type) != PBMessageType.socketPingPong.rawValue,
                    !self.messageBuffer.isEmpty {
                }
                self.socketSet[message.requestId] = nil
            }
            /// 业务错误
            if message.resultCode != 0 {
                let errorDescription = message.resultInfo ?? "未知错误\(message.resultCode)"
                let error = NSError(domain: "HuayingRequest", code: Int(message.resultCode), userInfo: [NSLocalizedDescriptionKey: errorDescription])
                request.didReceiveError(error)
                return
            }
            
            let bussinessData: Data
            /// 解密报文
            do {
                
                bussinessData = try self.decryptDataIfNeed(message, decryptor: self.encryptService?.decryptor)
                
            } catch let e {
                DPrint("[SocketParse]: \(e)")
                let error = NSError.huayingError(description: "[SocketParse]: \(e)")
                request.didReceiveError(error)
                return 
            }
            /// 成功应答
            request.didReceiveData(bussinessData)
            

        }
        /// 网络状态切换
        client.didChangeStatus = { [unowned self] status in
            let socketStatus = status.socketManagerState
            self.statusHandler?(socketStatus)
            switch status {
            case .connected:
                self.beginHeartBeat()
                DPrint("[SocketManager]: Connected to server \(self.address.absoluteString) succeess")
                /// 缓冲区的继续发送
                self.currentPendingState = .free
                (self.messageBuffer, self.currentPendingState) = self.dequeueSend(buffer: self.messageBuffer)
            case .disconnected:
                DPrint("[SocketManager]: DisConnected to server \(self.address.absoluteString)")
                self.stopHeartBeat()
            case .connecting:
                DPrint("[SocketManager]: Connecting to server \(self.address.absoluteString) ...")
                break
            }
        }
        
        return client
    }
    
    private func pingSocketMessageTemplate() -> PBSocketMessage {
        let message = PBSocketMessage()
        /// 心跳包不需要填 APPKey
        message.appKey = ""
        message.requestId = RequestIdGenerator.shared.generateId()
        message.type = UInt32(PBMessageType.socketPingPong.rawValue)
        message.timestamp = UInt64(Date().timeIntervalSince1970 * 1000)
        if case .signined(let token) = self.tokenStatus {
            message.accessToken = token
        }
        return message
    }
    
    private func socketMessageTemplate(_ bodyMessage: GPBMessage? , type: Int32) -> PBSocketMessage {
        let message = PBSocketMessage()
        
        message.requestId = RequestIdGenerator.shared.generateId()
        message.type = UInt32(type)
        message.timestamp = UInt64(Date().timeIntervalSince1970 * 1000)
        message.appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        self.deviceInfo.flatMap { message.device = $0.asPBDevice() }
        self.networkInfo.flatMap { message.network = $0.asPBNetwork() }
        
        if case .signined(let token) = self.tokenStatus {
            message.accessToken = token
        }
        
        let data = bodyMessage?.data() ?? Data()
        if !data.isEmpty {
            if let service = self.encryptService,
                let privateKey = service.encryptKeyStore?.privateKey {
                let encryptKeys = encryptKey(withPrivateKey: privateKey, requestId: message.requestId)
                message.encrypted = true
                message.messageData = service.encryptor.encrypt(data, usingStringKey: encryptKeys)
                message.appKey = service.encryptKeyStore!.publicKey
            } else {
                message.encrypted = false
                message.messageData = data
                /// 没有加密的话不用填
                message.appKey = ""
            }
        }
        return message
    }
    
    private func decryptDataIfNeed(_ message: PBSocketMessage , decryptor: Decryptor?)  throws -> Data {
        
        guard message.encrypted else {
            return message.messageData
        }
        guard let decryptor = decryptor else {
            throw NSError.huayingError(description: "返回数据加密了，但是客户端没有指定解密器")
        }
        guard  !message.messageData.isEmpty else {
            return Data()
        }
        
        guard let keyStore = self.encryptService?.keySet.first(where: { $0.publicKey == message.appKey }) else {
            throw NSError.huayingError(description: "请检查是否正确设置密钥对")
        }
        
        let decryptKey = encryptKey(withPrivateKey: keyStore.privateKey, requestId: message.requestId)
        
        guard let bussinessData = decryptor.decrypt(message.messageData, usingStringKey: decryptKey) else {
            throw NSError.huayingError(description: "返回数据解密有误")
        }

        return bussinessData

    }
    
    private func parseData(_ data: Data) -> PBSocketMessage? {
        let message = try? PBSocketMessage.parse(from: data)
        return message
    }
   
}

extension NSError {
    fileprivate static func huayingError(description: String) -> NSError {
        return NSError(domain: "HuayingSocketRequest", code: -1, userInfo: [NSLocalizedDescriptionKey: description])
    }
}

extension SocketClient.ConnectState {
    var socketManagerState: WebSocketManager.ConnectState {
        switch self {
        case .connected:
            return .connected
        case .connecting:
            return .connecting
        case .disconnected:
            return .disconnected
        }
    }
}

