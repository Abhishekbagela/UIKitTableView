//
//  ProductRepositoryProtocol.swift
//  TableView_Demo_UIkit
//
//  Created by Abhishek Bagela on 19/06/26.
//

import Foundation

// Interface segrigation protocol - A protocol should not force the other protocol to implement all the
// methods. so that segregate the protocols
//
//protocol AllFetchable {
//    associatedtype T
//    func fetchAll() async throws -> [T]?
//}
//
//protocol Fetchable {
//    associatedtype T
//    func fetch() async throws -> T?
//}
//
//protocol Deleteable {
//    func delete(id: String)
//}
//
//protocol Updatable {
//    associatedtype T
//    func update(object: T) async throws -> T?
//}
//
//protocol Creatable {
//    associatedtype T
//    func create(object: T) async throws -> T?
//}

//protocol BaseProtocol {
//    associatedtype T
//    
//    func fetchAll() async throws -> [T]
//    func fetch() async throws -> T
//    func delete(id: String)
//    func update(object: T) async throws -> T
//    func create(object: T) async throws -> T
//}

//extension


protocol ProductRepositoryProtocol {
    func fetchAll() async throws -> [Product]?
}
