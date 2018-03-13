//
//  MessageCenter.swift
//  MatchDay
//
//  Created by Garen on 16/10/10.
//  Copyright © 2016年 cgc. All rights reserved.
//

import Foundation

public func LOADING_TEXT(_ text: String) {
    TVProgressHUD.sharedInstance().showProgress(text)
}

public func HIDE_LOADING() {
    TVProgressHUD.sharedInstance().hideProgress()
}

public func LOADING() {
    TVProgressHUD.sharedInstance().showDefaultLodingHUD()
}

public func LOADING_DATA() {
    TVProgressHUD.sharedInstance().showDefaultLodingHUD()
}

public func LOADING_REQUEST() {
    TVProgressHUD.sharedInstance().showDefaultLodingHUD()
}




public func POSTMSG(_ message: String) {
    MessageCenter.sharedInstance().postSuccessMessage(message, duration: 1.5)
}

public func POSTMSG2(_ message: String,_ seconds:CGFloat) {
    MessageCenter.sharedInstance().postSuccessMessage(message, duration: seconds)
}

public func POST_SUCCESS_MSG(_ message: String) {
    MessageCenter.sharedInstance().postSuccessMessage(message, duration: 1.5)
}

public func POST_ERROR(_ message: String) {
    MessageCenter.sharedInstance().postSuccessMessage(message, duration: 3)
}

public func POST_TV_ERROR(_ error: Error) {
    MessageCenter.sharedInstance().postSuccessMessage(error.localizedDescription, duration: 3)
}




public func ERRORCENTER_POST_CUSTOM_ERROR(_ code: Int) {
    ErrorCenter.sharedInstance().postcustomError(withCode:code)
}

public func ERRORCENTER_POST_ERROR(_ error: Error) {
    ErrorCenter.sharedInstance().postError(error)
}

public func ERRORCENTER_ERROR(_ code: Int, _ message: String) -> Error! {
    return ErrorCenter.sharedInstance().error(withCode: code, message:message)
}
