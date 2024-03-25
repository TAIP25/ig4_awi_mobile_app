//
//  PlanningState.swift
//  test
//
//  Created by etud on 23/03/2024.
//

import Foundation

enum PlanningState {
    case loading
    case success
    //case success(days: [String], posts: [Poste], shifts: [CreneauHoraire], inscriptions: [InscriptionBenevole])
    case error(String)
}
