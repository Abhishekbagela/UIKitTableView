//
//  ImageLoader.swift
//  TableView_Demo_UIkit
//
//  Created by Abhishek Bagela on 23/06/26.
//

import Foundation

protocol ImageLoaderProtocol {
    func loadImage(_ url: URL) async throws -> Data
}

class ImageLoader: ImageLoaderProtocol {
    
    private let networkManager: NetworkClient
    init(networkManager: NetworkClient) {
        self.networkManager = networkManager
    }
    
    func loadImage(_ url: URL) async throws -> Data {
        try await networkManager.downloadImage(url)
    }
    
}
