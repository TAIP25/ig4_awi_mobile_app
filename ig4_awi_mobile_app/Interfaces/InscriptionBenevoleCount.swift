//
//  InscriptionBenevoleCount.swift
//  test
//
//  Created by etud on 24/03/2024.
//

import Foundation

struct InscriptionBenevoleCount: Codable{
    let posteID: Int
    let creneauHoraireID: Int
    let _count: Count

}

struct Count: Codable{
    let id: Int
}
