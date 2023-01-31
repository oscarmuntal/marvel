//
//  StringExtensions.swift
//  Marvel
//
//  Created by Òscar Muntal on 1/2/23.
//

import Foundation
import UIKit
import CryptoKit

extension String {
    var MD5: String {
        let computed = Insecure.MD5.hash(data: self.data(using: .utf8)!)
        return computed.map { String(format: "%02hhx", $0) }.joined()
    }
}
