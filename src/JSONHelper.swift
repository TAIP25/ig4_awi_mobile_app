//
//  JSONHelper.swift
//  ig4_awi_mobile_app
//
//  Created by Léon Boudier on 13/03/2024.
//

import Foundation

struct JSONHelper {
    static func loadFromFile(name: String, fileExtension: String) -> Data? {
        if let fileURL = Bundle.main.url(forResource: name, withExtension: fileExtension) {
            if let content = try? Data(contentsOf: fileURL) {
                return content
            }
        }
        return nil
    }
    
    static func decode<T: Decodable>(data: Data) -> T?{
        let decoder = JSONDecoder() // création d'un décodeur
        
        if let decoded = try? decoder.decode(T.self, from:data) { // si on a réussit à décoder
            //self.tracks = decoded
            return decoded
        }
        return nil
    }
    
}
