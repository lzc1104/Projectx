//
//  HuayingRequestTypeAddition.swift
//  Pods
//
//  Created by 王小涛 on 2017/8/14.
//
//

import Foundation

public struct DeviceInfo {
    
    public let deviceId: String
    
    // like iOS8.2, iOS10.3.2
    public let deviceOS: String
    
    // like iPhone5, iPhone7 Plus
    public let deviceModel: String
    
    public let screenSize = UIScreen.main.bounds.size
    
    public init(deviceId: String, deviceOS: String, deviceModel: String) {
        self.deviceId = deviceId
        self.deviceOS = deviceOS
        self.deviceModel = deviceModel
    }
    
    
}

extension DeviceInfo {
    func asPBDevice() -> PBDevice {
        let device = PBDevice()
        device.deviceType = .deviceIos
        device.deviceId = self.deviceId
        device.deviceModel = self.deviceModel
        device.deviceOs = self.deviceOS
        let screenSize: PBDeviceScreenSize = {
            let size = PBDeviceScreenSize()
            size.width = Int32(self.screenSize.width)
            size.height = Int32(self.screenSize.height)
            return size
        }()
        device.screenSize = screenSize
        return device
    }
}

public struct NetworkInfo {
    public enum NetworkType {
        case unknow
        case cellular2G
        case cellular3G
        case cellular4G
        case wifi
    }
    
    public let networkType: NetworkType
    
    public init(networkType: NetworkType) {
        self.networkType = networkType
    }
    
    var asPBNetworkType: PBNetworkType {
        switch networkType {
        case .unknow:
            return .netUnknown
        case .cellular2G:
            return .net2G
        case .cellular3G:
            return .net3G
        case .cellular4G:
            return .net4G
        case .wifi:
            return .netWifi
        }
    }
}

extension NetworkInfo {
    func asPBNetwork() -> PBNetwork {
        let network = PBNetwork()
        network.type = self.asPBNetworkType
        return network
    }
}
