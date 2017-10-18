//
//  Protocolbuf.swift
//  Pods
//
//  Created by 王小涛 on 2017/8/7.
//
//

import Protobuf

public protocol Protocolbuf {
    init(data: Data) throws
}

extension Protocolbuf where Self: GPBMessage {
    public init(data: Data) throws {
        self = try Self.parse(from: data)
    }
}
