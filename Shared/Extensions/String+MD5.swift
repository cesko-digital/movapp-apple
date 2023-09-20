//
//  String+MD5.swift
//  Movapp (iOS)
//
//  Created by Martin Kluska on 15.05.2022.
//

import CryptoKit
import Foundation

extension String {
    func md5Hash() -> String {
        return Insecure.MD5.hash(data: self.data(using: .utf8)!).map { String(format: "%02hhx", $0) }.joined()
    }

}
