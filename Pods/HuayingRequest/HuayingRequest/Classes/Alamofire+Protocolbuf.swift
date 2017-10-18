//
//  Alamofire+Protocolbuf.swift
//  Pods
//
//  Created by 王小涛 on 2017/8/7.
//
//

import Alamofire

extension DataRequest {
    
    static func protocolbufResponseSerializer<T: Protocolbuf>()
        -> DataResponseSerializer<T>
    {
        return DataResponseSerializer { _, response, data, error in
            return Request.serializeResponseProtocolbuf(response: response, data: data, error: error)
        }
    }
    
    @discardableResult
    public func responseProtocolbuf<T: Protocolbuf>(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<T>) -> Void)
        -> Self
    {
        return response(
            queue: queue,
            responseSerializer: DataRequest.protocolbufResponseSerializer(),
            completionHandler: completionHandler
        )
    }
}

extension Request {
    
    static func serializeResponseProtocolbuf<T: Protocolbuf>(
        response: HTTPURLResponse?,
        data: Data?,
        error: Error?)
        -> Result<T>
    {
        guard error == nil else { return .failure(error!) }
        
        guard let validData = data, validData.count > 0 else {
            return .failure(AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength))
        }
        
        do {
            let object = try T(data: validData)
            return .success(object)
        } catch let error {
            return .failure(error)
        }
    }
}
