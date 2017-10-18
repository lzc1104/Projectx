//
//  HuayingWebSocketManager.swift
//  Pods
//
//  Created by lzc1104 on 2017/9/19.
//
//

import Foundation
import Alamofire


/// 广播的报文类型
///
/// - multiSignin: 多点登录
/// - unknowned: 未知类型，请上层自行处理
public enum WebSocketPublishAction {
    case multiSignin(signinData: PBUserLoginData)
    case unknowned(type: Int32,data: Data)
    
    public init(type: Int32,data: Data) {
        switch type {
        case PBMessageType.socketMultiLogin.rawValue:
            let data = try? PBUserLoginData.parse(from: data)
            self = .multiSignin(signinData: data ?? PBUserLoginData())
            break
        default:
            self = .unknowned(type: type,data: data)
        }
    }
}


/// 便利的 Socket 消息请求类型
public protocol WebSocketCommonRequestCommand {
    
    /// 返回体的目标类型 ，暂时只支持 Void 和 GPBMessage
    associatedtype CallbackType
    
    /// 消息的请求体
    ///
    /// - Returns: 消息的请求体
    func message() -> GPBMessage?
    
    /// 请求类型
    var type: Int32 { get }
}

public struct SocketSigninCommand: WebSocketCommonRequestCommand {
    public typealias CallbackType = Void
    var userId: String
    public init(userId: String) {
        self.userId = userId
    }
    public func message() -> GPBMessage? {
        let value = PBStrValue()
        value.value = self.userId
        return value
    }
    
    public var type: Int32 {
        return PBMessageType.socketLogin.rawValue
    }
    
}

public struct SubscribeTopicCommand: WebSocketCommonRequestCommand {
    public typealias CallbackType = Void
    var topic: String
    public init(topic: String) {
        self.topic = topic
    }
    
    public func message() -> GPBMessage? {
        let value = PBStrValue()
        value.value = self.topic
        return value
    }
    
    public var type: Int32 {
        return PBMessageType.socketSubscribeTopic.rawValue
    }
}

public struct UnsubscribeTopicCommand: WebSocketCommonRequestCommand {
    public typealias CallbackType = Void
    var topic: String
    public init(topic: String) {
        self.topic = topic
    }
    
    public func message() -> GPBMessage? {
        let value = PBStrValue()
        value.value = self.topic
        return value
    }
    
    public var type: Int32 {
        return PBMessageType.socketUnsubscribeTopic.rawValue
    }
}



/// 储存公私钥的结构体
public struct KeyChainStore: Hashable {
    
    /// 公钥 - 对应的是 AppKey
    var publicKey: String
    /// 私钥 - 对应的是 AppSectet
    var privateKey: String
    
    public static func ==(lhs: KeyChainStore, rhs: KeyChainStore) -> Bool {
        return lhs.publicKey == rhs.publicKey
    }
    
    public var hashValue: Int {
        return publicKey.hashValue
    }
    
    public init(publicKey: String , privateKey: String) {
        self.publicKey = publicKey
        self.privateKey = privateKey
    }
    
}


/// 业务 Socket 管理者
/// Features:
/// 1.心跳机制 - 超时心跳自动重连服务器
/// 2.socket 消息模拟HTTP应答机制
/// 3.socket 消息超时检测
/// 4.socket 自动重连机制
/// 5.socket 消息包语义正确性
/// 6.心跳包和业务消息包队列分离 -- //TODO
open class HuayingWebSocketManager {
    
    public enum ConnectState {
        case connected
        case disconnected
        case connecting
        
    }
    public enum TokenStatus {
        case authroied(String)
        case notYet
    }
    ///MARK: - Public properties
    
    /// 业务要求: 所有的请求若已经登录，需带有对应的 AccessToken ，若没有则设置为 .notYet
    public var tokenStatus: TokenStatus = .notYet {
        didSet {
            switch self.tokenStatus {
            case .notYet:
                self.manager.tokenStatus = .notYet
            case .authroied(let userToken):
                self.manager.tokenStatus = .signined(userToken)
            }
            
        }
    }
    ///MARK: - Private properties
    private var manager: WebSocketManager
    private var encryptService: EncryptService?
    private var singleSigninCenter: SingleSigninProtocol?
    private var connectedCallback: (() -> Void)?
    private var disConnectedCallback: (() -> Void)?
    
    ///MARK: - Hook
    public typealias ActionHandler = (WebSocketPublishAction) -> Void
    
    /// 收到的广播报文句柄
    open var actionHandler: ActionHandler?
    /// 网络状态处理句柄
    open var statusHandler: ((ConnectState) -> Void)?
    
    /// 标准构造函数
    ///
    /// - Parameters:
    ///   - address: 服务器地址
    ///   - encryService: 加密套件
    public init(address: URL,
                encryService: EncryptService?,
                deviceInfo: DeviceInfo? = nil,
                networkInfo: NetworkInfo? = nil,
                singleSigninCenter: SingleSigninProtocol? = nil) {
        
        self.singleSigninCenter = singleSigninCenter
        self.manager = WebSocketManager(
            address: address,
            encryptService: encryService,
            deviceInfo: deviceInfo,
            networkInfo: networkInfo
        )
        
        self.manager.publishDataHandler = { [unowned self] data , type in
            let action = WebSocketPublishAction(type: Int32(type),data: data)
            self.actionHandler?(action)
            
            ///拦截登录业务
            if case .multiSignin(let signinData) = action {
                self.singleSigninCenter?.forceSignout(ForceSignOutReason.init(loginData: signinData))
            }
            
        }
        
        self.manager.statusHandler = { [unowned self] status in
            switch status {
            case .connected:
                self.statusHandler?(.connected)
                self.connectedCallback?()
                self.connectedCallback = nil
            case .connecting:
                self.statusHandler?(.connecting)
            case .disconnected:
                self.statusHandler?(.disconnected)
                self.disConnectedCallback?()
                self.disConnectedCallback = nil
            }
            
        }
        
    }
    
    /// 标准 WebSocket 消息请求函数
    ///
    /// - Parameters:
    ///   - message: 请求内容
    ///   - type: 请求类型
    ///   - callback: 请求结果处理的句柄
    /// - Returns: 用于取消请求的抽象协议对象
    @discardableResult
    open func sendSocketMessage<R: GPBMessage>(_
        message: GPBMessage? ,
        type: Int32 ,
        callback: ((Result<R?>) -> Void)?)
        -> Disposeable {
            
        return self.manager.sendSocketMessage(message, type: type) { (result: Result<R?>) in
            callback?(result)
            
            ///拦截登录业务
            if case .failure(let error) = result,
                let reason = ForceSignOutReason.init(error: (error as NSError)){
                self.singleSigninCenter?.forceSignout(reason)
            }
        }
    }
    
    
    /// 便利 WebSocket 消息请求函数, 适用于返回体为空的情况
    ///
    /// - Parameters:
    ///   - command: 请求的封装结构
    ///   - callback: 请求结果处理的句柄
    /// - Returns: 用于取消请求的抽象协议对象
    @discardableResult
    open func sendSocketMessage<T : WebSocketCommonRequestCommand>(
        command: T ,
        callback: ((Result<Void>) -> Void)?)
        -> Disposeable where T.CallbackType == Void {
        return self.manager.sendSocketMessage(command.message(), type: command.type, callback: { (result: Result<GPBMessage?>) in
            let flatMapResult = result.flatMap({ value in
                return ()
            })
            callback?(flatMapResult)
            
            ///拦截登录业务
            if case .failure(let error) = result,
                let reason = ForceSignOutReason.init(error: (error as NSError)){
                self.singleSigninCenter?.forceSignout(reason)
            }
        })
    }
    
    /// 便利 WebSocket 消息请求函数, 适用于返回体为 GPBMessage 类型的情况
    ///
    /// - Parameters:
    ///   - command: 请求的封装结构
    ///   - callback: 请求结果处理的句柄
    /// - Returns: 用于取消请求的抽象协议对象
    @discardableResult
    open func sendSocketMessage<T : WebSocketCommonRequestCommand>(
        command: T ,
        callback: ((Result<T.CallbackType>) -> Void)?)
        -> Disposeable  where T.CallbackType : GPBMessage  {
        return self.manager.sendSocketMessage(command.message(), type: command.type, callback: { (result: Result<T.CallbackType?>) in
            let flatMapResult = result.flatMap({ value -> T.CallbackType in
                return value ?? T.CallbackType()
            })
            callback?(flatMapResult)
            
            ///拦截登录业务
            if case .failure(let error) = result,
                let reason = ForceSignOutReason.init(error: (error as NSError)){
                self.singleSigninCenter?.forceSignout(reason)
            }
        })
    }
    
    /// 连接至构造器传入的服务器地址
    open func connect(_ operation: (() -> Void)? = nil) {
        self.manager.connect()
        self.connectedCallback = operation
    }
    /// 断开连接
    open func disConnect(_ operation: (() -> Void)? = nil) {
        self.manager.disconnect()
        self.disConnectedCallback = operation
    }
    
    
}
