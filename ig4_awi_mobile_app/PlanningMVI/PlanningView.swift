//
//  PlanningView.swift
//  test
//
//  Created by etud on 20/03/2024.
//

import SwiftUI

struct PlanningView: View {
    @ObservedObject var viewModel: PlanningViewModel
    @ObservedObject var festivalVM: FestivalViewModel


    var body: some View {
        VStack {
            
            if let festival = festivalVM.festival {
                Text("Festival édition \(festival.edition) ")
            } 
            Picker("Select a day", selection: $viewModel.selectedDay) {
                ForEach(viewModel.days, id: \.self) { day in
                    Text(day)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            
            
                List(viewModel.postes) { post in
                    VStack(alignment: .leading) {
                        Button(action:{
                            
                        }
                        ){
                            Button(action: {
                                self.viewModel.selectedPost = post
                            }) {
                                Text(post.nom)
                                    .font(.headline)
                            }
                            if let selectedPost = viewModel.selectedPost, selectedPost == post {
                                ForEach(viewModel.filteredCreneauxHoraires, id: \.id) { creneau in
                                    let key = KeyInscription(creneauId: creneau.id, postId: post.id)
                                    if let inscriptionBenevole = viewModel.inscriptionBenevole[key] {
                                        HStack {
                                            Text("\(creneau.jour): \(creneau.heureDebut)h - \(creneau.heureFin)h")
                                            Spacer()
                                            ProgressView(value: Double(inscriptionBenevole.nombreInscrits), total: Double(inscriptionBenevole.nombreMax))
                                            Spacer()
                                            Button(action: {
                                                // Gérer l'action du bouton en fonction de l'état
                                                if let monInscription = viewModel.getMonInscriptionBenevole(posteID: post.id, creneauHoraireID: creneau.id) {
                                                    switch monInscription.status {
                                                    case "En attente":
                                                        viewModel.handleAnnulerReservation(festivalId: festivalVM.festival!.id, posteId: post.id, creneauHoraireId: creneau.id)
                                                    default:
                                                        break
                                                    }
                                                } else if inscriptionBenevole.nombreInscrits < inscriptionBenevole.nombreMax {
                                                    viewModel.handleReservation(festivalId: festivalVM.festival!.id, posteId: post.id, creneauHoraireId: creneau.id)
                                                }
                                            }) {
                                                // Définir le titre du bouton en fonction de l'état
                                                if let monInscription = viewModel.getMonInscriptionBenevole(posteID: post.id, creneauHoraireID: creneau.id) {
                                                    Text("\(monInscription.status)")
//                                                    switch monInscription.status {
//                                                    case "Accepté":
//                                                        Text("Accepté")
//                                                    case "Refusé":
//                                                        Text("Refusé")
//                                                    case "En attente":
//                                                        Text("En attente")
//                                                    default:
//                                                        Text("")
//                                                    }
                                                } else if inscriptionBenevole.nombreInscrits >= inscriptionBenevole.nombreMax {
                                                    Text("Plein")
                                                } else {
                                                    Text("Réserver")
                                                }
                                            }
                                            
                                        }
                                    }
                                }
                            }}
                    }
                }
            
            // Afficher les créneaux horaires et les checkboxes en fonction du jour et du poste sélectionnés

        }
        .onAppear {
            self.festivalVM.fetchNextFestival()
            self.viewModel.fetchPostes(festivalId: festivalVM.festival!.id)
            self.viewModel.fetchCreneauxHoraires(festivalId: festivalVM.festival!.id)
            self.viewModel.fetchMyInscriptionBenevole(festivalId: festivalVM.festival!.id)
        }
        .onChange(of: viewModel.selectedDay){ oldState, newState in
            viewModel.fetchCreneauxHoraires(festivalId: festivalVM.festival!.id)
        }
        
    }
}
