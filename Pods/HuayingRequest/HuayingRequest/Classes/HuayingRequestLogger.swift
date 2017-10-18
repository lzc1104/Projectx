//
//  HuayingRequestLogger.swift
//  Pods
//
//  Created by 王小涛 on 2017/8/8.
//
//

import Foundation
import Alamofire
import Protobuf

public enum LogLevel {
    case none
    case brief
    case detail
}

class HuayingRequestLogger {
    
    static func log<T: GPBMessage>(logLevel: LogLevel = .brief, message: GPBMessage?, httpBody: PBMessageRequest, response: DataResponse<PBMessageResponse>, result: Result<T>? = nil) {
        
        #if DEBUG
            
            switch logLevel {
            case .detail:
                let detail = debugDescription(of: message, httpBody: httpBody, response: response)
                let logMessage = [detail, result?.debugDescription].flatMap({ $0 }).joined(separator: "\n")
                log(logMessage)
            case .brief:
                let brief = briefDebugDescription(of: message, httpBody: httpBody, response: response)
                let logMessage = [brief, result?.debugDescription].flatMap({ $0 }).joined(separator: "\n")
                log(logMessage)
            case .none:
                break
            }
            
         
        #endif
    }
    
    private static func log(_ message: @autoclosure () -> Any) {
        print("==================================================================================================")
        print(message())
        print("==================================================================================================")
    }
    
    private static func debugDescription(of message: GPBMessage?, httpBody: PBMessageRequest, response: DataResponse<PBMessageResponse>) -> String {
        var output: [String] = []
        
        output.append(response.request != nil ? "[Request]: \(response.request!.httpMethod ?? "GET") \(response.request!)" : "[Request]: nil")
        output.append("[Request HttpHeaders]: \(response.request?.allHTTPHeaderFields ?? [:])")
        output.append("[Request HttpBody]: \(httpBody)")
        output.append("[HttpBody message]: \(String(describing: message))")
        output.append(response.response != nil ? "[Response]: \(response.response!)" : "[Response]: nil")
        output.append("[Data]: \(response.data?.count ?? 0) bytes")
        output.append("[Result]: \(response.result.debugString)")
        output.append("[Result MessageData]: \(response.result.value?.messageData.count ?? 0) bytes")
        output.append("[Timeline]: \(response.timeline.debugDescription)")
        
        return output.joined(separator: "\n")
    }
    
    private static func briefDebugDescription(of message: GPBMessage?, httpBody: PBMessageRequest, response: DataResponse<PBMessageResponse>) -> String {
        var output: [String] = []
        
        output.append(response.request != nil ? "[Request]: \(response.request!.httpMethod ?? "GET") \(response.request!)" : "[Request]: nil")
        output.append("[Request Message Type]: \(httpBody.type)")
        output.append("[Request Message]: \(String(describing: message))")
        
        output.append("[Result]: \(response.result.debugString)")
        output.append("[Result MessageData]: \(response.result.value?.messageData.count ?? 0) bytes")
        
        return output.joined(separator: "\n")
    }
}

extension Result where Value == PBMessageResponse {
    /// The debug textual representation used when written to an output stream, which includes whether the result was a
    /// success or failure in addition to the value or error.
    public var debugString: String {
        switch self {
        case .success(let value):
            return "SUCCESS: \(value.debugString)"
        case .failure(let error):
            return "FAILURE: \(error)"
        }
    }
}

extension PBMessageResponse {
    
    public var debugString: String {
        let newSelf = self.copy() as! PBMessageResponse
        newSelf.messageData = Data()
        return newSelf.debugDescription
    }
}
