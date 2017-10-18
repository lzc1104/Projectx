//
//  Encryptor&Decryptor.swift
//  Pods
//
//  Created by 王小涛 on 2017/8/8.
//
//

import Foundation

public protocol Encryptor {
    func encrypt(_ data: Data, usingStringKey: String) -> Data?
}

public protocol Decryptor {
    func decrypt(_ data: Data, usingStringKey: String) -> Data?
}

struct XXTEAEncryptor: Encryptor {
    func encrypt(_ data: Data, usingStringKey key: String) -> Data? {
        return XXTEA.encrypt(data, stringKey: key)
    }
}

struct XXTEADecryptor: Decryptor {
    func decrypt(_ data: Data, usingStringKey key: String) -> Data? {
        return XXTEA.decrypt(data, stringKey: key)
    }
}
