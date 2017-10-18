//
//  NetworkExtension.swift
//  ProjectX
//
//  Created by lzc1104 on 2017/10/18.
//  Copyright © 2017年 ProjectX. All rights reserved.
//

import Foundation

import UICKeyChainStore


extension UIDevice {

    public var deviceId: String {
        guard let deviceId = UICKeyChainStore.string(forKey: "DeviceUniqueIdentifier") else {
            let deviceId = UUID().uuidString
            UICKeyChainStore.setString(deviceId, forKey: "DeviceUniqueIdentifier")
            return deviceId
        }
        return deviceId
    }
}
