//
//  Mapper.swift
//  TableView_Demo_UIkit
//
//  Created by Abhishek Bagela on 20/06/26.
//

import Foundation

struct Mapper {
    
    static func mapIntoProduct(from dto: ProductDTO) -> Product {
        return Product(
            id: dto.id,
            title: dto.title,
            description: dto.description,
            images: dto.images
        )
    }
    
}
