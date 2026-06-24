//
//  Extension+String.swift
//  TableView_Demo_UIkit
//
//  Created by Abhishek Bagela on 24/06/26.
//

import Foundation
import CryptoKit

extension String {
    
    var cacheKey: String {
        let digest = SHA256.hash(data: Data(self.utf8))
        return digest.compactMap {
            String(format: "%02x", $0)
        }.joined()
    }
    
}
