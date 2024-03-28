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
    
    @ObservedObject var festivalVM: FestivalViewModel
    
    let logo = UIImage(named: "logo_vectorise")
    
    let user = UserDefaults.standard.data(forKey: "benevole")
    
    var body: some View {
        
        let benevole : Benevole = try! JSONDecoder().decode(Benevole.self, from: user!)

        VStack {
            Image(uiImage: logo!)
                .resizable()
                .frame(width: 256, height: 151)
            
            Text("Bienvenue \(benevole.prenom)")
                .font(.system(size: 24))
            
            if let festival = festivalVM.festival {
                Text("Le festival édition \(festival.edition) commence bientôt!")
            } else {
                Text("Chargement...")
            }
            
            if case .isRegister = festivalVM.state{
                Text("Votre inscription est validé ! ")
                Text("N'hésitez pas à consulter le planning ")
            } else{
                Button(action: {
                    router.navigate(to: .festivalRegister)
                }){
                    Text("M'inscrire")
                }
                .padding(10)
                .background(.teal.opacity(0.25))
                .cornerRadius(10)
                .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.teal, lineWidth: 1)
                )            }

            
            Spacer()
                        
            NavbarView()
        }
        .padding(.bottom)
        .onAppear {
            self.festivalVM.fetchNextFestival()
            
        }
        .onChange(of: festivalVM.state){ oldState, newState in 
            if case let .loaded(festival) = newState{
                festivalVM.isRegisterToFestival(festivalID: festival.id, benevoleID: benevole.id)
            }
            
        }
    }
}
