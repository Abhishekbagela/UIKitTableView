//
//  APIManager.swift
//  TableView_Demo_UIkit
//
//  Created by Abhishek Bagela on 23/06/26.
//

import Foundation

protocol APIProtocol {
    func fetchAllProduct() async throws -> [ProductDTO]?
    func fetchProduct(_ id: Int) async throws -> ProductDTO?
    func saveProduct(_ product: ProductDTO) async throws
    func deleteProduct(_ id: Int) async throws
    func updateProduct(_ product: ProductDTO) async throws -> ProductDTO?
}

struct APIManager: APIProtocol {
    
    private let networkManager: NetworkClient
    init(networkManager: NetworkClient) {
        self.networkManager = networkManager
    }
    
    func fetchAllProduct() async throws -> [ProductDTO]? {
        print("\(#function)")
        
        let request = NetworkRequest(
            url: .products,
            method: .GET
        )
        
        guard let data = try await networkManager.request(request) else {
            return nil
        }
        
        return JsonUtility.decode(data)
    }
    
    func fetchProduct(_ id: Int) async throws -> ProductDTO? {
        print("\(#function)")
        return ProductDTO(id: 0, title: "", description: "", images: [""])
    }
    
    func saveProduct(_ product: ProductDTO) async throws {
        print("\(#function)")
    }
    
    func deleteProduct(_ id: Int) async throws {
        print("\(#function)")
    }
    
    func updateProduct(_ product: ProductDTO) async throws -> ProductDTO? {
        print("\(#function)")
        return ProductDTO(id: 1, title: "", description: "", images: [""])
    }
    
}


/*
struct MockApiManager: APIProtocol {
    func fetchAllProduct() -> [ProductDTO] {
        []
    }
    
    func fetchProduct(_ id: Int) -> ProductDTO {
        ProductDTO(id: 0, title: "", description: "", images: [""])
    }
    
    func saveProduct(_ product: ProductDTO) {
        
    }
    
    func deleteProduct(_ id: Int) {
        
    }
    
    func updateProduct(_ product: ProductDTO) -> ProductDTO {
        ProductDTO(id: 1, title: "", description: "", images: [""])
    }
}
*/
