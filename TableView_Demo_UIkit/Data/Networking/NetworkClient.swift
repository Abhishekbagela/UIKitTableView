//
//  NetworkClient.swift
//  TableView_Demo_UIkit
//
//  Created by Abhishek Bagela on 19/06/26.
//

import Foundation

protocol NetworkClient {    
    func request(_ request: NetworkRequest) async throws -> Data?
    
    func downloadImage(_ url: URL) async throws -> Data
}

struct NetworkRequest {
    var url: URL
    var method: HTTPMethod
    var body: Data?
    var header: [String: String]?
    var query: [String: String]?
    
    init(
        url: NetworkURL,
        method: HTTPMethod,
        body: Data? = nil,
        header: [String : String]? = nil,
        query: [String : String]? = nil
    ){
        self.url = URL(string: url.rawValue)!
        self.method = method
        self.body = body
        self.header = header
        self.query = query
    }
}


enum HTTPMethod: String {
    case GET
    case POST
}

enum NetworkURL: String {    
    case products = "https://api.escuelajs.co/api/v1/products"
}

enum NetworkError: Error {
    case ServerError // 500
    case ImageNotFound // 404
    case Unknown(Error) // Unknown error
    case DataNotFound
}
