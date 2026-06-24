//
//  DiskCache.swift
//  TableView_Demo_UIkit
//
//  Created by Abhishek Bagela on 23/06/26.
//

import Foundation

actor DiskCache {
    
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    
    init(folderName: String = "ImageCache") {
        let cachesURL = fileManager.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        ).first!
        
        cacheDirectory = cachesURL.appendingPathComponent(folderName)
        
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            try? fileManager.createDirectory(
                at: cacheDirectory,
                withIntermediateDirectories: true
            )
        }
    }
    
    func data(for key: String) -> Data? {
        let fileURL = cacheDirectory.appendingPathComponent(key)
        return try? Data(contentsOf: fileURL)
    }
    
    func save(_ data: Data, for key: String) {
        let fileURL = cacheDirectory.appendingPathComponent(key)
        try? data.write(to: fileURL)
    }
    
    func delete(for key: String) {
        let fileURL = cacheDirectory.appendingPathComponent(key)
        try? fileManager.removeItem(at: fileURL)
    }
    
    func clear() {
        try? fileManager.removeItem(at: cacheDirectory)
        
        try? fileManager.createDirectory(
            at: cacheDirectory,
            withIntermediateDirectories: true
        )
    }
}
