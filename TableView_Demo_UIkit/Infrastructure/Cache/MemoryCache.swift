//
//  MemoryCache.swift
//  TableView_Demo_UIkit
//
//  Created by Abhishek Bagela on 24/06/26.
//

import Foundation
import UIKit

// NOTE: Here we have used actor to prevent data races because we are mutating the shared `cache` property.
actor InMemoryCache {
    private var cache = NSCache<NSString, UIImage>()
    
    func object(for key: NSString) -> UIImage? {
        cache.object(forKey: key)
    }
    
    func setObject(_ obj: UIImage, for key: NSString) {
        cache.setObject(obj, forKey: key)
    }
}
