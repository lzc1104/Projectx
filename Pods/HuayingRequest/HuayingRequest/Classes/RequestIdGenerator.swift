//
//  RequestIdGenerator.swift
//  Pods
//
//  Created by 王小涛 on 2017/8/8.
//
//

import Foundation

class RequestIdGenerator {
    
    static let shared = RequestIdGenerator()
    
    private var currentId: UInt64 = 0
    
    private let internalQueue: DispatchQueue = DispatchQueue(label:"LockingQueue") // Serial by default
    
    private init() {}
    
    func generateId() -> UInt64 {
        return internalQueue.sync {
            currentId = currentId + 1
            
            return currentId
        }
    }
}
