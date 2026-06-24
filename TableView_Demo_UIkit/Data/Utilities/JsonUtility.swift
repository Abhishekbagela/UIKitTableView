//
//  JsonUtility.swift
//  TableView_Demo_UIkit
//
//  Created by Abhishek Bagela on 20/06/26.
//

import Foundation

enum JsonUtility {
    
    static func decode<T: Decodable>(_ data: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            return nil
        }
    }
    
    static func encode<T: Encodable>(_ object: T) -> Data? {
        let encoder = JSONEncoder()
        do {
            return try encoder.encode(object)
        } catch {
            return nil
        }
    }

}
