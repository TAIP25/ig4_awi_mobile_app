//
//  JeuxSousEspaceFestival.swift
//  test
//
//  Created by etud on 28/03/2024.
//

import Foundation

struct JeuxSousEspaceFestival: Codable{
    
    let jeuID : Int
    let sousEspaceDeJeuID: Int
    let festivalID: Int
    let sousEspaceDeJeu : EspaceJeu
    let jeu : Jeu
    let createdAt: String
    let updatedAt: String
    
    
}
