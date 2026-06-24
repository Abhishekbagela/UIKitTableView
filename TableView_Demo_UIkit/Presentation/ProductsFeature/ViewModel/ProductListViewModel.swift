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
    private let imageLoader: ImageLoaderProtocol
    init(productListUseCase: FetchAllProductUseCase, imageLoader: ImageLoaderProtocol) {
        self.productListUseCase = productListUseCase
        self.imageLoader = imageLoader
    }
    
    func fetchAllProducts() async throws {
        let products = try await productListUseCase.execute()
        productList = products ?? []
        
        print(self.productList.count)
        productList.forEach { p in
            print("xcxcxc image\(p.images.first)")
        }
    }
    
    func getProductImage(_ url: String) async throws -> Data? {
        guard let url = URL(string: url) else {
            print("\(#function) url nil")
            return nil
        }
        return try await imageLoader.loadImage(url)
    }
}
