//
//  EspaceJeu.swift
//  test
//
//  Created by etud on 28/03/2024.
//

import Foundation

struct EspaceJeu: Codable, Hashable {
    
    let id: Int
    var nom: String
    let description: String?
    let nombreBenevoles: Int
    let espaceDeJeuID: Int
    let createdAt: String
    let updatedAt: String
    
    
}
