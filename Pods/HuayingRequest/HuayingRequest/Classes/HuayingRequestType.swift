//
//  HuayingRequestType.swift
//  Pods
//
//  Created by 王小涛 on 2017/8/7.
//
//

import Foundation
import Alamofire
import Protobuf

public protocol RequestAccessorable {
    func requestWillStart()
    func requestDidFinish()
}

extension PBMessageResponse: Protocolbuf {}

public protocol Cancellable {
    func cancel()
}

public protocol HuayingRequestType: Cancellable {}



extension Request: HuayingRequestType {}

extension HuayingRequestServiceType {
	
    public var secretKeys: [String: String] {
        return [:]
    }
    
    public var httpDNSService: DNSServiceType? {
        return nil
    }
    
    public var encryptor: Encryptor? {
        return XXTEAEncryptor()
    }
    
    public var decryptor: Decryptor? {
        return XXTEADecryptor()
    }
    
    public var currentDevice: DeviceInfo? {
        return nil
    }
    
    public var currentNetwork: NetworkInfo? {
        return nil
    }

    public var logLevel: LogLevel {
        return .brief
    }
    
    public var singleSigninCenter: SingleSigninProtocol? {
        return nil
    }
    
    public var accessToken : String? {
        return nil
    }
    
    
    
}

extension HuayingRequestServiceType {
    @discardableResult
    public func response<T: GPBMessage>(type: UInt32,
                         message: GPBMessage? = nil,
                         accessory: RequestAccessorable? = nil,
                         completed: @escaping (Result<T>) -> Void)
        -> HuayingRequestType? {
        
        let body = httpBody(with: type, message: message)
        guard let urlRequest = request(withHttpBody: body) else {
            return nil
        }
        let dataRequest = SessionManager.default.request(urlRequest).validate()
        accessory?.requestWillStart()
        dataRequest.responseProtocolbuf { (response: DataResponse<PBMessageResponse>) in
            let result: Result<T> = self.explain(response: response, decryptor: self.decryptor, secretKeys: self.secretKeys)
            HuayingRequestLogger.log(logLevel: self.logLevel, message: message, httpBody: body, response: response, result: result)
            accessory?.requestDidFinish()
            completed(result)
            
            ///拦截登录业务
            if case .failure(let error) = result,
                let reason = ForceSignOutReason.init(error: (error as NSError)){
                self.singleSigninCenter?.forceSignout(reason)
            }
        }
        return dataRequest
    }
    
    @discardableResult
    public func response(type: UInt32,
                         message: GPBMessage? = nil,
                         accessory: RequestAccessorable? = nil,
                         completed: @escaping (Result<Void>) -> Void)
        -> HuayingRequestType? {
        
        let body = httpBody(with: type, message: message)
        guard let urlRequest = request(withHttpBody: body) else {
            return nil
        }
        let dataRequest = SessionManager.default.request(urlRequest).validate()
        accessory?.requestWillStart()
        dataRequest.responseProtocolbuf { (response: DataResponse<PBMessageResponse>) in
            let result: Result<Void> = self.explain(response: response)
            HuayingRequestLogger.log(logLevel: self.logLevel, message: message, httpBody: body, response: response)
            accessory?.requestDidFinish()
            completed(result)
            
            ///拦截登录业务
            if case .failure(let error) = result,
                let reason = ForceSignOutReason.init(error: (error as NSError)){
                self.singleSigninCenter?.forceSignout(reason)
            }
        }
        return dataRequest
    }
    
    @discardableResult
    public func response<T: GPBMessage>(type: UInt32,
                         message: GPBMessage? = nil,
                         accessory: RequestAccessorable? = nil,
                         success: ((T) -> Void)? = nil,
                         failure: ((NSError) -> Void)? = nil)
        -> HuayingRequestType? {
            
            return response(type: type, message: message, accessory: accessory) { (result: Result<T>) in
            switch result {
            case let .success(value):
                success?(value)
            case let .failure(error):
                failure?(error as NSError)
            }
            ///拦截登录业务
            if case .failure(let error) = result,
                let reason = ForceSignOutReason.init(error: (error as NSError)){
                self.singleSigninCenter?.forceSignout(reason)
            }
        }
    }
    
    @discardableResult
    public func response(type: UInt32,
                         message: GPBMessage? = nil,
                         accessory: RequestAccessorable? = nil,
                         success: (() -> Void)? = nil,
                         failure: ((NSError) -> Void)? = nil)
        -> HuayingRequestType? {
            
        return response(type: type, message: message, accessory: accessory) { (result: Result<Void>) in
            switch result {
            case .success:
                success?()
            case let .failure(error):
                failure?(error as NSError)
            }
            ///拦截登录业务
            if case .failure(let error) = result,
                let reason = ForceSignOutReason.init(error: (error as NSError)){
                self.singleSigninCenter?.forceSignout(reason)
            }
        }
    }
}


enum ResolveResult {
    case host(urlString: String)
    case ip(urlString: String, host: String)
}

extension HuayingRequestServiceType {
    
    fileprivate func request(withHttpBody body: PBMessageRequest) -> URLRequest? {
        
        let resolveResult: ResolveResult = {
            
            let urlString = baseUrl + "?&m=req&format=pb"
            
            guard let httpDNSService = httpDNSService,
                let url = URL(string: urlString),
                let host = url.host,
                let ip = httpDNSService.resolveInURLFormat(host: host) else {
                    return .host(urlString: urlString)
            }
            
            return .ip(urlString: urlString.replacingOccurrences(of: host, with: ip), host: host)
        }()
        
        let urlString: String = {
            switch resolveResult {
            case let .host(urlString):
                return urlString
            case let .ip(urlString, _):
                return urlString
            }
        }()
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "post"
        
        request.addValue("application/x-protobuf", forHTTPHeaderField: "Content-Type")
        
        if case let .ip(_, host) = resolveResult {
            request.addValue(host, forHTTPHeaderField: "Host")
        }
        
        request.httpBody = body.data()
        
        return request
    }
    
    fileprivate func httpBody(with type: UInt32, message: GPBMessage?) -> PBMessageRequest {
        
        let requestId = RequestIdGenerator.shared.generateId()
        
        let postMessage = PBMessageRequest()
        
        postMessage.type = type
        
        let secretKey: (public: String, private: String)? = {
            guard secretKeys.count > 0 else {
                return nil
            }
            let index = Int(arc4random_uniform(UInt32(secretKeys.count)))
            let key = secretKeys.flatMap{ $0.key }[index]
            let value = secretKeys[key]!
            return (key, value)
        }()
        
        postMessage.appKey = secretKey?.public
        
        postMessage.requestId = requestId
        
        postMessage.timestamp = UInt64(NSDate().timeIntervalSince1970 * 1000)
        
        let device: PBDevice? = {
            guard let currentDevice = currentDevice else {return nil}
            let device = PBDevice()
            device.deviceType = .deviceIos
            device.deviceId = currentDevice.deviceId
            device.deviceModel = currentDevice.deviceModel
            device.deviceOs = currentDevice.deviceOS
            let screenSize: PBDeviceScreenSize = {
                let size = PBDeviceScreenSize()
                size.width = Int32(currentDevice.screenSize.width)
                size.height = Int32(currentDevice.screenSize.height)
                return size
            }()
            device.screenSize = screenSize
            return device
        }()
        postMessage.device = device
        
        let network: PBNetwork? = {
            guard let currentNetwork = currentNetwork else {return nil}
            let network = PBNetwork()
            network.type = currentNetwork.asPBNetworkType
            return network
        }()
        postMessage.network = network
        
        let bundleShortVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        postMessage.appVersion = bundleShortVersion
        
        /// 1.1 accsess token required
        self.accessToken.flatMap{ postMessage.accessToken = $0 }
        
        let wrapData: (data: Data?, isEncrypt: Bool) = {
            
            guard let data = message?.data() else {
                return (nil, false)
            }
            
            guard data.count > 0 else {
                return (data, false)
            }
            
            guard let encryptor = encryptor else {
                print("Warning: 没有加密器，无法加密。")
                return (data, false)
            }
            
            guard let privateKey = secretKey?.private else {
                print("Warning: 虽然有加密器，但是secretKeys为空，无法加密。")
                return (data, false)
            }
            
            let key = encryptKey(withPrivateKey: privateKey, requestId: requestId)
            if let data = encryptor.encrypt(data, usingStringKey: key) {
                return (data, true)
            } else {
                print("Warning: 无法加密，请检查privateKey: \(privateKey)是否正确")
                return (data, false)
            }
        }()
        
        postMessage.encrypted = wrapData.isEncrypt
        postMessage.messageData = wrapData.data
        
        return postMessage
    }
}

extension HuayingRequestServiceType {

    fileprivate func explain<T: GPBMessage>(response: DataResponse<PBMessageResponse>, decryptor: Decryptor?, secretKeys: [String: String]) -> Result<T> {
        
        return response.result.flatMapError(response.errorMap)
            .flatMap {
                
                guard $0.resultCode == 0 else {
                    let errorDescription = $0.resultInfo ?? "未知错误\($0.resultCode)"
                    let error = NSError(domain: "HuayingRequest", code: Int($0.resultCode), userInfo: [NSLocalizedDescriptionKey: errorDescription])
                    throw error
                }
                
                guard let data = $0.messageData else {
                    let error = NSError.huayingError(description: "messageData为空")
                    throw error
                }
                
                guard data.count > 0, $0.encrypted else {
                    return try T.parse(from: data)
                }
                
                guard let decryptor = decryptor else {
                    let error = NSError.huayingError(description: "返回数据加密了，但是客户端没有指定解密器")
                    throw error
                }
                
                guard let appKey = $0.appKey else {
                    let error = NSError.huayingError(description: "返回数据加密了，但是appKey为空，无法解密")
                    throw error
                }
                
                guard let privateKey = secretKeys[appKey] else {
                    let error = NSError.huayingError(description: "无法找到appKey对应的privateKey，无法解密")
                    throw error
                }
                
                let decryptKey = encryptKey(withPrivateKey: privateKey, requestId: $0.requestId)
                
                guard let unwrapData = decryptor.decrypt(data, usingStringKey: decryptKey) else {
                    let error = NSError.huayingError(description: "无法解密，请检查privateKey: \(privateKey) 是否正确")
                    throw error
                }
                return try T.parse(from: unwrapData)
        }
    }
    
    fileprivate func explain(response: DataResponse<PBMessageResponse>) -> Result<Void> {
        
        return response.result.flatMapError(response.errorMap)
            .flatMap {
                if $0.resultCode != 0 {
                    let error = NSError.huayingError(description: $0.resultInfo ?? "未知错误\($0.resultCode)")
                    throw error
                }
        }
    }
}


extension DataResponse where Value == PBMessageResponse {
    
    fileprivate func errorMap(error: Error) -> NSError {
        guard result.isSuccess else {
            if let res = response {
                let error = NSError.huayingError(description: "服务器貌似出问题了\(res.statusCode)")
                return error
            } else {
                let error = NSError.huayingError(description: "网络貌似没有连接，请检查你的网络")
                return error
            }
        }
        return error as NSError
    }
}

extension NSError {
    fileprivate static func huayingError(description: String) -> NSError {
        return NSError(domain: "HuayingRequest", code: -1, userInfo: [NSLocalizedDescriptionKey: description])
    }
}

public func encryptKey(withPrivateKey privateKey: String, requestId: UInt64) -> String {
    
    let requestIdString = String(requestId) as NSString
    var hash: UInt64 = 5381
    
    for i in 0..<requestIdString.length {
        hash = ((hash << 5) &+ hash) + UInt64(requestIdString.character(at: i))
    }
    hash = ((hash) ^ (hash >> 16)) & 0x0fff
    
    return privateKey + String(format: "%04ld", hash)
}
