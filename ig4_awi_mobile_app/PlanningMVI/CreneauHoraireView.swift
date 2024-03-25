////
////  CreneauHoraireView.swift
////  test
////
////  Created by etud on 23/03/2024.
////
//
//import Foundation
//
//import SwiftUI
//
//struct CreneauHoraireView: View {
//    @ObservedObject var viewModel: CreneauHoraireViewModel
//    
//    init(viewModel: CreneauHoraireViewModel) {
//        self.viewModel = viewModel
//    }
//    
//    var body: some View {
//        VStack {
//            if viewModel.viewState.isLoading {
//                ProgressView()
//            } else if let errorMessage = viewModel.viewState.errorMessage {
//                Text(errorMessage)
//            } else {
//                Button(action: {
//                    viewModel.process(intent: .changeDay)
//                }) {
//                    Text(viewModel.viewState.selectedDay.rawValue)
//                        .padding()
//                        .background(Color.gray.opacity(0.2))
//                        .cornerRadius(10)
//                }
//                Text(
//                    viewModel.viewState.selectedCreneauHoraire.map { creneauHoraire in
//                        "\(creneauHoraire.jour) de \(creneauHoraire.heureDebut)h à \(creneauHoraire.heureFin)h"
//                    } ?? "Not selected"
//                )
//                List(filterCreneauxHoraires(), id: \.id) { creneauHoraire in
//                    Button(action: {
//                        viewModel.process(intent: .selectCreneauHoraire(creneauHoraire))
//                    }) {
//                        Text("\(creneauHoraire.heureDebut)h à \(creneauHoraire.heureFin)h")
//                    }
//                }
//            }
//        }
//        .onAppear {
//            viewModel.process(intent: .loadCreneauxHoraires)
//        }
//    }
//
//    // Fonction pour filtrer les créneaux horaires en fonction du jour sélectionné
//    private func filterCreneauxHoraires() -> [CreneauHoraire] {
//        if viewModel.viewState.selectedDay == .samedi {
//            return viewModel.viewState.creneauxHoraires.filter { $0.jour == "Samedi" }
//        } else {
//            return viewModel.viewState.creneauxHoraires.filter { $0.jour == "Dimanche" }
//        }
//    }
//}
