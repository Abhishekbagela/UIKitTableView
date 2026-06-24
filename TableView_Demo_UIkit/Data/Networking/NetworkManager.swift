//
//  NetworkManager.swift
//  TableView_Demo_UIkit
//
//  Created by Abhishek Bagela on 19/06/26.
//

import Foundation

struct NetworkManager: NetworkClient {
    
    func request(_ request: NetworkRequest) async throws -> Data? {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.header
        urlRequest.httpBody = request.body
        
        // MARK: Add query params
        if let requestQuery = request.query {
            var queryItems: [URLQueryItem] = []
            for query in requestQuery {
                let item = URLQueryItem(name: query.key, value: query.value)
                queryItems.append(item)
            }
            
            urlRequest.url?.append(queryItems: queryItems)
        }

        dump("xcxcxcxc urlRequest: \(urlRequest)")
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let response = (response as? HTTPURLResponse), 200...299 ~= response.statusCode
        else {
            return nil
        }
        dump("xcxcxcxc response: \(response.statusCode)")
        return data
    }
    
    func downloadImage(_ url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, 200...300 ~= response.statusCode else {
            throw NetworkError.ServerError
        }
        
        return data
    }
    
}
