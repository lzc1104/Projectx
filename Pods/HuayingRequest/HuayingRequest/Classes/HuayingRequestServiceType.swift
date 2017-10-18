//
//  HuayingRequestServiceType.swift
//  Pods
//
//  Created by Garen on 2017/9/12.
//
//

import Foundation
import Alamofire
import Protobuf
import PromiseKit

public protocol HuayingRequestServiceType {
	
	var baseUrl: String {get}
	// [publicKey: privatekey]
	var secretKeys: [String: String] {get}
	
	var httpDNSService: DNSServiceType? {get}
	
	//    var encryptor: Encryptor? {get}
	//    var decryptor: Decryptor? {get}
	
	var currentDevice: DeviceInfo? {get}
	var currentNetwork: NetworkInfo? {get}
    var singleSigninCenter: SingleSigninProtocol? { get }
    var accessToken : String? { get }
	var logLevel: LogLevel {get}
	
	@discardableResult
	func response<T: GPBMessage>(type: UInt32, message: GPBMessage?, accessory: RequestAccessorable?, completed: @escaping (AFResult<T>) -> Void) -> HuayingRequestType?
	@discardableResult
	func response(type: UInt32, message: GPBMessage?, accessory: RequestAccessorable?, completed: @escaping (AFResult<Void>) -> Void) -> HuayingRequestType?
	
	@discardableResult
	func response<T: GPBMessage>(type: UInt32, message: GPBMessage?, accessory: RequestAccessorable?, success: ((T) -> Void)?, failure: ((NSError) -> Void)?) -> HuayingRequestType?
	@discardableResult
	func response(type: UInt32, message: GPBMessage?, accessory: RequestAccessorable?, success: (() -> Void)?, failure: ((NSError) -> Void)?) -> HuayingRequestType?
	
	@discardableResult
	func promiseResponse<T: GPBMessage>(type: UInt32, message: GPBMessage?, accessory: RequestAccessorable?) -> Promise<T>
	
	@discardableResult
	func promiseResponse(type: UInt32, message: GPBMessage?, accessory: RequestAccessorable?) -> Promise<Void>
	
}

extension HuayingRequestServiceType {
	
	public func promiseResponse<T: GPBMessage>(type: UInt32,
	                            message: GPBMessage? = nil,
	                            accessory: RequestAccessorable? = nil) -> Promise<T> {
		
		return Promise<T>(resolvers: { (fullfill, reject) in
			
			self.response(type: type,
			              message: message,
			              accessory: accessory,
			              completed: { (result: AFResult<T>) in
							
				switch result {
				case .success(let resultValue):
					fullfill(resultValue)
				case .failure(let error):
					reject(error)
				}
							
			})
		})
	}

	public func promiseResponse(type: UInt32,
	                            message: GPBMessage? = nil,
	                            accessory: RequestAccessorable? = nil) -> Promise<Void> {
		return Promise<Void>(resolvers: { (fullfill, reject) in
			
			self.response(type: type,
			              message: message,
			              accessory: accessory,
			              completed: { (result: AFResult<Void>) in
							
				switch result {
				case .success(let resultValue):
					fullfill(resultValue)
				case .failure(let error):
					reject(error)
				}
							
			})
		})
	}
	
}











