//
//  Poste.swift
//  test
//
//  Created by etud on 23/03/2024.
//

import Foundation


struct Poste: Codable, Identifiable, Equatable{
    
    let id: Int
    var nom: String
    let description: String
    let nombreBenevoles: Int
    let createdAt: String
    let updatedAt: String
    
    // Implementing Equatable
    static func == (lhs: Poste, rhs: Poste) -> Bool {
        return lhs.id == rhs.id &&
               lhs.nom == rhs.nom &&
               lhs.description == rhs.description &&
               lhs.createdAt == rhs.createdAt
    }
    
}
