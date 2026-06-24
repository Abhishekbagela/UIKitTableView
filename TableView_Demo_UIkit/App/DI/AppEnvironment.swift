//
//  AppContainer.swift
//  TableView_Demo_UIkit
//
//  Created by Abhishek Bagela on 19/06/26.
//

import Foundation

final class DependencyContainer {
    
    lazy var networkManager: NetworkManager = {
        NetworkManager()
    }()
    
    lazy var api: APIProtocol = {
        APIManager(networkManager: networkManager)
    }()
    
    lazy var productRepository: ProductRepository = {
        ProductRepository(api: api)
    }()
    
    lazy var productListUseCase: FetchAllProductUseCase = {
        FetchAllProductUseCase(repository: productRepository)
    }()
    
    lazy var imageLoader: ImageLoaderProtocol = {
        ImageLoader(networkManager: networkManager)
    }()
    
    func makeProductListViewModel() -> ProductListViewModel {
        ProductListViewModel(productListUseCase: productListUseCase, imageLoader: imageLoader)
    }
}

@MainActor
struct AppEnvironment {
    static let factory: DependencyContainer = DependencyContainer()
}
