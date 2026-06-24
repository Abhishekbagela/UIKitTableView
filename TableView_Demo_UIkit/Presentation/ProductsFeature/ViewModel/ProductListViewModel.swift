//
//  ProductListViewModel.swift
//  TableView_Demo_UIkit
//
//  Created by Abhishek Bagela on 19/06/26.
//

import Foundation
import Observation

@Observable
final class ProductListViewModel {
    
    var productList: [Product] = []
    
    private let productListUseCase: FetchAllProductUseCase
    init(productListUseCase: FetchAllProductUseCase) {
        self.productListUseCase = productListUseCase
    }
    
    func fetchAllProducts() async throws {
        let products = try await productListUseCase.execute()
        productList = products ?? []
        
        print(self.productList.count)
        productList.forEach { p in
            print("xcxcxc image\(p.images.first)")
        }
    }
}
