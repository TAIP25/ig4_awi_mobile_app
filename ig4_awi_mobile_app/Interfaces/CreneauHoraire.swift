//
//  CreneauHoraire.swift
//  test
//
//  Created by etud on 23/03/2024.
//

import Foundation

struct CreneauHoraire: Codable {
    let id: Int
    let jour: String
    let heureDebut: Int
    let heureFin: Int
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case jour
        case heureDebut
        case heureFin
        case createdAt
        case updatedAt
    }
    
}
