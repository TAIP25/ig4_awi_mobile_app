//
//  FestivalBenevole.swift
//  test
//
//  Created by etud on 22/03/2024.
//

import Foundation

struct FestivalBenevole: Codable{
    
    let id: Int
    let festivalID: Int
    let benevoleID: Int
    let presenceSamedi:    Bool?
    let presenceDimanche:  Bool?
    let repasSamediMidi:   Bool?
    let repasSamediSoir:   Bool?
    let repasDimancheMidi: Bool?
    let tShirtPris: Bool?
    let createdAt: String
    let updatedAt: String
    
}

