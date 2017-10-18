//
//  BasicConfigManager.swift
//  Pods
//
//  Created by 王小涛 on 2017/8/15.
//
//

import Foundation
import Alamofire

public protocol StoreServiceType {
    func set(data value: Data?, forKey key: String)
    func data(forKey key: String) -> Data?
}

public struct BasicConfigManagerNotification {
    public static let didFinishLoad = Foundation.Notification.Name("didFinishLoad")
}

public class BasicConfigManager<B: Protocolbuf> {
    
    private let keyForBasicConfig = "huaying_config_key"
    
    public private(set) var basicConfig: PBBasicConfig?
    public private(set) var businessConfig: B?
    
    private let networkService: HuayingRequestServiceType
    private let storeService: StoreServiceType
    
    public var localConfigFilePath: String?

    public init(network: HuayingRequestServiceType, store: StoreServiceType) {
        networkService = network
        storeService = store
        
        // 先从storeService中获取数据，获取不到，再从localConfigFilePath中获取
        let data: Data? = {
            if let data = storeService.data(forKey: keyForBasicConfig) {
                return data
            } else if let filePath = localConfigFilePath {
                let url = URL(fileURLWithPath: filePath)
                return try? Data(contentsOf: url)
            }
            return nil
        }()
        
        if let data = data {
            basicConfig = try? PBBasicConfig.parse(from: data)
            businessConfig = businessConfig(from: basicConfig)
        }
        
        // 从服务器中拉最新数据
        load()
    }
    
    private func load() {
    
        networkService.response(type: UInt32(PBMessageType.basicConfigGet.rawValue), message: nil, completed: { (result: Result<PBBasicConfig>) in
            
            switch result {
            case let .success(value):
                print("Ah........................., load basic config from server success!!!")
                print("basic config = \(value)")
                self.basicConfig = value
                self.businessConfig = self.businessConfig(from: value)
                self.storeService.set(data: value.data(), forKey: self.keyForBasicConfig)
            case let .failure(error):
                print("Oh no......................, load basic config from server failed, error = \(error.localizedDescription)")
                break
            }
            NotificationCenter.default.post(name: BasicConfigManagerNotification.didFinishLoad, object: self, userInfo: nil)
        })
    }
    
    private func businessConfig(from config: PBBasicConfig?) -> B? {
        guard let config = config,
            let data = config.businessConfig,
            let businessConfig = try? B(data: data) else {
            return nil
        }
        return businessConfig
    }
    
    public func storeBasicConfigIntoFile() {
        guard let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            return
        }
        let filePath = dir + "/config_ios.pb"
        try? basicConfig?.data()?.write(to: URL(fileURLWithPath: filePath))
    }
}
