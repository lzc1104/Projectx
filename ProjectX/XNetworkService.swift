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

    static let shared = XNetworkService()

    var baseUrl: String {
        return "http://fxsys.com.hk:9980/api"
    }

    var secretKeys: [String: String] {
        return [:]
    }
    
    
    var httpDNSService: DNSServiceType? {
        return nil
    }
    
    var currentDevice: DeviceInfo? {
        return nil

    }
    
    var currentNetwork: NetworkInfo? {
        
        return nil
    }
    
    var logLevel: LogLevel {
        return .detail
    }
}



