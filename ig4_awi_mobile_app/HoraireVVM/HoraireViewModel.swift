//
//  HoraireViewModel.swift
//  ig4_awi_mobile_app
//
//  Created by Léon Boudier on 13/03/2024.
//

import SwiftUI

protocol HoraireProtocol {
    var hD: Int { get set }
    var hF: Int { get }
}

class HoraireViewModel: HoraireProtocol, Hashable, ObservableObject {
    
    @Published var hD: Int
    @Published var hF: Int
    
    init(hD: Int, hF: Int) {
        self.hD = hD
        self.hF = hF
    }
    
    static func == (lhs: HoraireViewModel, rhs: HoraireViewModel) -> Bool {
        return lhs.hD == rhs.hD && lhs.hF == rhs.hF
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(hD+hF)
    }
    
    
    
}
