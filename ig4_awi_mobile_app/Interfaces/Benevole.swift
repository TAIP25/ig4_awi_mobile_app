//
//  Benevole.swift
//  test
//
//  Created by etud on 17/03/2024.
//

struct Benevole: Codable {
    let id: Int
    let nom: String
    let prenom: String
    let email: String
    let password: String
    let pseudo: String
    let statut: String
    let tailleTShirt: String?
    let vegetarien: Bool?
    let hebergement: String?
    let jeuFavoriId: Int?
    let picture: Int?
    let associationID: Int?
    let adresse: String?
    let telephone: String?
    let createdAt: String
    let updatedAt: String
    // Ajoutez d'autres propriétés du bénévole si nécessaire
}
