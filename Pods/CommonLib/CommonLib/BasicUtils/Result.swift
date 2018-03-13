//
//  Result.swift
//  PokerQuan
//
//  Created by lzc1104 on 2017/5/18.
//  Copyright © 2017年 Dewinsports. All rights reserved.
//

import Foundation


public enum Result<T > {
    case Success(T)
    case Failure(Error)
}

extension Result {
    public var value : T? {
        switch self {
        case .Success(let guy):
            return guy
        default:
            return nil
        }
    }
    
    public var error : Error? {
        switch self {
        case .Failure(let error):
            return error
        default:
            return nil
        }
    }
    
    public func map<U>(_ transform :  ((T) throws -> U)) rethrows -> Result<U> {
        switch self {
        case .Success(let value):
            return .Success(try transform(value))
        case .Failure(let error):
            return .Failure(error)
        }
    }
    
    public func flatMap<U>(_ transform : ((T) throws -> Result<U>)) rethrows -> Result<U> {
        switch self {
        case .Success(let value):
            return try transform(value)
        case .Failure(let error):
            return .Failure(error)
        }
    }
}
