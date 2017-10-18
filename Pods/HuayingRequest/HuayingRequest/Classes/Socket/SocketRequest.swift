//
//  SocketRequest.swift
//  Pods
//
//  Created by lzc1104 on 2017/9/19.
//
//

import Foundation
import Protobuf
import Alamofire

class SocketRawRequest: Disposeable {
    
    func dispose() {
        fatalError()
    }
    
    func didReceiveData(_ data: Data) {
        fatalError()
    }
    
    func didReceiveError(_ error: NSError) {
        fatalError()
    }
    
    func cancel() {
        fatalError()
    }
    
    func datas() -> Data {
        fatalError()
    }
    
    func timeStamp() -> UInt64 {
        fatalError()
    }
    
    func requestId() -> UInt64 {
        fatalError()
    }
    
    static func ==(lhs: SocketRawRequest, rhs: SocketRawRequest) -> Bool {
        return rhs.requestId() == lhs.requestId()
    }
    
    
}

class SocketRequest< R: GPBMessage >: SocketRawRequest {
    typealias CallBack = ((Result<R?>) -> Void)
    var message: PBSocketMessage
    var data: GPBMessage?
    var callback: CallBack?
    
    init(message: PBSocketMessage, body: GPBMessage? , callback: CallBack?) {
        self.data = body
        self.callback = callback
        self.message = message
    }
    
    override func didReceiveData(_ data: Data) {
        let message: R? = try? R.parse(from: data)
        let result: Result<R?> = .success(message)
        self.logMessage(result)
        DispatchQueue.main.async {
            self.callback?(result)
        }
    }
    
    override func didReceiveError(_ error: NSError) {
        
        let result: Result<R?> = .failure(error)
        self.logMessage(result)
        
        DispatchQueue.main.async {
            self.callback?(result)
        }
    }
    
    private func logMessage(_ result: Result<R?>) {
        
        let printData = self.data ?? GPBMessage()
        
        var output: [String] = []
//        let seperator = Array.init(repeating: "*", count: 20).joined()
//        output.append(seperator)
        output.append("[SocketRequest Message Type]: \(self.message.type)")
        output.append("[SocketRequest Message]: \(printData)")
        output.append("[SocketResult]: \(result)")
        switch result {
        case .success(let value):
            let value = value ?? R()
            output.append("[SocketResult Message Body]: \(String(describing: value))")
        case .failure(let error):
            output.append("[SocketResult Error]: \(error)")
        }
//        output.append(seperator)
        let wrap = output.joined(separator: "\n")
        print(wrap)
    }
    
    override func cancel() {
        self.callback = nil
    }
    
    override func dispose() {
        self.callback = nil
    }
    
    override func datas() -> Data {
        return self.message.data() ?? Data()
    }
    
    override func timeStamp() -> UInt64 {
        return self.message.timestamp
    }
    
    override func requestId() -> UInt64 {
        return self.message.requestId
    }
    
}
