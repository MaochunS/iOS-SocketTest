//
//  Data+Extension.swift
//  APPCommon
//
//  Created by maochun on 2020/7/23.
//  Copyright © 2020 maochun. All rights reserved.
//

import Foundation
import CommonCrypto
import CryptoKit



extension Digest {
    var bytes: [UInt8] { Array(makeIterator()) }
    var data: Data { Data(bytes) }

    var hexStr: String {
        bytes.map { String(format: "%02X", $0) }.joined()
    }
}

extension Data {
    
    public var bytes: [UInt8] {
    
        return [UInt8](self)
    }
    
    public var hexString: String {
        return reduce("") {$0 + String(format: "%02x", $1)}
    }
    
    public var md5Data: Data? {
        if #available(iOS 13.0, *) {
            return Insecure.MD5.hash(data:self).data
        }else{
            var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            self.withUnsafeBytes { bytes in
                _ = CC_MD5(bytes.baseAddress, CC_LONG(self.count), &digest)
            }
            return Data(bytes: digest, count: digest.count)
        }
    }
    
    public var sha256: Data? {
        if #available(iOS 13.0, *) {
            let digest = SHA256.hash(data: self)
            return digest.data
        } else {
            var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
            self.withUnsafeBytes { bytes in
                _ = CC_SHA256(bytes.baseAddress, CC_LONG(self.count), &digest)
            }
            return Data(bytes: digest, count: digest.count)
        }
    }
    
   
}
