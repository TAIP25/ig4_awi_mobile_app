//
//  Jeu.swift
//  test
//
//  Created by etud on 28/03/2024.
//

import Foundation


struct Jeu: Codable, Identifiable, Hashable{
    
    let id: Int
    var nom: String
    let auteur: String
    let editeur: String
    let nombreJoueurs: String?
    let ageMin: Int?
    let duree: Int?
    let type: String
    let notice: String?
    let recu: Bool
    let aAnimer: Bool
    let createdAt: String
    let updatedAt: String
    
    
}
