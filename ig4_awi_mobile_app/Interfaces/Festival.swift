//
//  Festival.swift
//  test
//
//  Created by etud on 21/03/2024.
//

struct Festival: Codable, Equatable, Hashable {
    let id: Int
    let edition: String
    let dateDebut: String
    let dateFin: String
    
    // Implementing Equatable
    static func == (lhs: Festival, rhs: Festival) -> Bool {
        return lhs.id == rhs.id &&
               lhs.edition == rhs.edition &&
               lhs.dateDebut == rhs.dateDebut &&
               lhs.dateFin == rhs.dateFin
    }
    
    // Implementing Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(edition)
        hasher.combine(dateDebut)
        hasher.combine(dateFin)
    }
}

