//
//  ProductRepository.swift
//  TableView_Demo_UIkit
//
//  Created by Abhishek Bagela on 19/06/26.
//

import Foundation

class ProductRepository: ProductRepositoryProtocol {
    private let api: APIProtocol
    init(api: APIProtocol) {
        self.api = api
    }
    
    func fetchAll() async throws -> [Product]? {
        let dtoList = try await api.fetchAllProduct()
        
        return dtoList?.map { dto in
            Mapper.mapIntoProduct(from: dto)
        }
    }
    
}
