//
//  ImageCache.swift
//  TableView_Demo_UIkit
//
//  Created by Abhishek Bagela on 23/06/26.
//

import Foundation
import UIKit

//final class ImageCache {
// NOTE: Here we have used actor to prevent data races because we are mutating the shared `runningTasks` property.
actor ImageCache {
    
    static let shared = ImageCache()
    
    private var memoryCache = InMemoryCache()
    private var diskCache = DiskCache()
    
    private var runningTasks: [String: Task<UIImage?, Error>] = [:]
    
    private init() { }
    
    func image(for urlString: String) async throws -> UIImage? {
        
        let key = await urlString.cacheKey
        
        // MEMORY CACHE
        
        if let image = await memoryCache.object(for: key as NSString) {
            print("✅ Memory Cache Hit")
            return image
        }
        
        // DISK CACHE
        
        if let data = await diskCache.data(for: key), let image = UIImage(data: data) {
            print("💾 Disk Cache Hit")
            await memoryCache.setObject(image, for: key as NSString)
            return image
        }
        
        // REQUEST DEDUPLICATION - Check the task is already running for the same image then it should return the image instead of creating the new task.
        
        if let existingTask = runningTasks[urlString] {
            print("🔄 Existing Task")
            return try await existingTask.value
        }
        
        // NETWORK
        
        let task = Task<UIImage?, Error> {
            
            defer {
                Task {
                    self.removeTask(for: urlString)
                }
            }
            
            guard let url = URL(string: urlString) else {
                return nil
            }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            
            try Task.checkCancellation()
            
            guard let image = UIImage(data: data) else {
                return nil
            }
            
            // SAVE TO MEMORY
            
            await self.storeInMemory(image, key: key)
            
            // SAVE TO DISK
            
            await self.storeInDisk(data, key: key)
            
            print("🌐 Network Download")
            
            return image
        }
        
        //Store the task so that we can check if it already in_progress for same image then it should not start for the same image.
        runningTasks[urlString] = task
        
        return try await task.value
    }
    
    private func storeInMemory(_ image: UIImage, key: String) async {
        await memoryCache.setObject(image, for: key as NSString)
    }
    
    private func storeInDisk(_ data: Data, key: String) async {
        await diskCache.save(data, for: key)
    }
    
    private func removeTask(for key: String) {
        runningTasks.removeValue(forKey: key)
    }
}
