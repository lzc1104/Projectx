//
//  XNetworkService.swift
//  ProjectX
//
//  Created by lzc1104 on 2017/10/18.
//  Copyright © 2017年 ProjectX. All rights reserved.
//

import Foundation
import HuayingRequest
import Device


class XNetworkService: HuayingRequestServiceType {


    var baseUrl: String {
        return ""
    }

    var secretKeys: [String: String] {
        return [:]
    }
    
    
    var httpDNSService: DNSServiceType? {
        return nil
    }
    
    var currentDevice: DeviceInfo? {
        return nil
//        let deviceId = UIDevice.current.deviceId
//        let deviceOS = UIDevice.current.systemName + UIDevice.current.systemVersion
//        let deviceModel = Device.version().rawValue
//        let device = DeviceInfo(deviceId: deviceId, deviceOS: deviceOS, deviceModel: deviceModel)
//        return device
    }
    
    var currentNetwork: NetworkInfo? {
        
        return nil
    }
    
    var logLevel: LogLevel {
        return .detail
    }
}



