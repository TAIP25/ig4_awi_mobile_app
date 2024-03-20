//
//  HomeView.swift
//  test
//
//  Created by etud on 19/03/2024.
//

import SwiftUI

struct HomeView: View {
    
    let logoHome = UIImage(named: "accueil")
    let logoPlanning = UIImage(named: "planning")
    let logoUser = UIImage(named: "user")
    
    @EnvironmentObject var router: Router
    
    let user = UserDefaults.standard.data(forKey: "benevole")
    
    var body: some View {
        
        let benevole : Benevole = try! JSONDecoder().decode(Benevole.self, from: user!)

        
        VStack {
            Image(systemName: "house.fill")
                .font(.system(size: 56))
                .foregroundColor(.accentColor)
            Text("Bienvenue \(benevole.prenom)")
                .font(.system(size: 24))
            
            Spacer()
                        
            NavbarView()
        }
        .padding(.bottom)
    }
}
