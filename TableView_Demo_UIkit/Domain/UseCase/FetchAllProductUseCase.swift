//
//  FetchAllProductUseCase.swift
//  TableView_Demo_UIkit
//
//  Created by Abhishek Bagela on 19/06/26.
//

import Foundation

class FetchAllProductUseCase {
    
    private let repository: ProductRepositoryProtocol
    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> [Product]? {
        try await repository.fetchAll()
    }
}
