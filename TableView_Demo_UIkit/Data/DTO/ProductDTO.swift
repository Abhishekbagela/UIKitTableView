//
//  ProductDTO.swift
//  TableView_Demo_UIkit
//
//  Created by Abhishek Bagela on 20/06/26.
//

import Foundation

struct ProductDTO: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let images: [String]
}
