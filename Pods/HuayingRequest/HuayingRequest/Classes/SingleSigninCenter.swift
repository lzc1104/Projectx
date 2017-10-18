//
//  SingleSigninCenter.swift
//  Pods
//
//  Created by lzc1104 on 2017/9/21.
//
//

import Foundation

public enum ForceSignOutReason {
    case userNotLoginYet
    case userAccessTokenExpired
    case userAccessTokenInvalid
    case forceSignOut(PBUserLoginData)
    
    public init?(error: NSError) {
        let code = Int32(error.code)
        guard let pbError = PBError(rawValue: code) else { return nil }
        switch pbError {
        case .userNotLoginYet:
            self = .userNotLoginYet
            break
        case .userAccessTokenInvalid:
            self = .userAccessTokenInvalid
            break
        case .userAccessTokenExpired:
            self = .userAccessTokenExpired
            break
        default:
            return nil
        }
    }
    
    public init(loginData: PBUserLoginData) {
        self = .forceSignOut(loginData)
    }
    
}

public protocol SingleSigninProtocol {
    func forceSignout(_ reason: ForceSignOutReason)
}

