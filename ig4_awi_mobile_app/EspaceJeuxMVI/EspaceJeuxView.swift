//
//  EspaceJeuxView.swift
//  test
//
//  Created by etud on 28/03/2024.
//

import SwiftUI

struct EspaceJeuxView: View{
    
    @ObservedObject var viewModel : EspaceJeuxViewModel
    @ObservedObject var festivalVM : FestivalViewModel
    
    var body: some View{
        
        VStack{
            
            Text("Liste des espaces de jeux")
            
            switch viewModel.state{
                    case .loading:
                        Text("Chargement des espaces de jeux...")
                    case .error(let erreur):
                        Text(erreur)
                    case .success:
                        List(viewModel.espacesJeux, id: \.self) { espace in

                            VStack(alignment: .leading) {
                                Button(action: {
                                    self.viewModel.selectedEspace = espace
                                }) {
                                    Text(espace.nom)
                                        .font(.headline)
                                }

                                // Afficher les jeux du sous espace
                                if let jeux = viewModel.sousEspacesJeux[espace.id] {
                                    ForEach(jeux, id: \.self) { jeu in
                                        Text(jeu.nom)
                                    }
                                }
                            }
                        }
                    }
            
            
        }
        .onAppear{
            self.festivalVM.fetchNextFestival()
            self.viewModel.fetchSousEspaceJeux(festivalId: festivalVM.festival!.id)
            self.viewModel.fetchJeuxSousEspaceFestival(festivalId: festivalVM.festival!.id )
        }
    }
}
