//
//  EspaceJeuxVIewModel.swift
//  test
//
//  Created by etud on 28/03/2024.
//

import SwiftUI



class EspaceJeuxViewModel: ObservableObject{
    
    @Published var state: EspaceJeuxState = .loading
    @Published var espacesJeux : [EspaceJeu] = []
    @Published var selectedEspace : EspaceJeu?
    @Published var sousEspacesJeux : [Int: [Jeu]] = [:] // Un dictionnaire avec la clé étant le sous espace de jeu et la valeur étant un tableau de jeux

    
    func fetchSousEspaceJeux(festivalId: Int){
        
        state = .loading
        
        let url = URL(string: "https://festival-du-jeu-api.onrender.com/sousEspaceJeu")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async { // Déplacez tout le code suivant sur le thread principal
                if let _error = error {
                    self.state = .error("Erreur")
                    return
                }
                
                guard let data = data else {
                    self.state = .error("Erreur")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    
                    print(String(data: data, encoding: .utf8) ?? "No data")

                                        
                    let response = try decoder.decode([EspaceJeu].self, from: data)
                    
                    self.espacesJeux = response
                    
                    print("espacesJeux")
                    print(self.espacesJeux)
                    self.state = .success
                    
                    
                    
                } catch {
                    self.state = .error("Impossible de décoder la réponse")
                }
            }
        }.resume()
    }
    
    func fetchJeuxSousEspaceFestival(festivalId: Int){
        
        state = .loading
        
        let url = URL(string: "https://festival-du-jeu-api.onrender.com/jeuSousEspaceFestival/\(festivalId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async { // Déplacez tout le code suivant sur le thread principal
                if let _error = error {
                    self.state = .error("Erreur")
                    return
                }
                
                guard let data = data else {
                    self.state = .error("Erreur")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    
                    //print(String(data: data, encoding: .utf8) ?? "No data")

                                        
                    let response = try decoder.decode([JeuxSousEspaceFestival].self, from: data)
                    
                    // Créer un dictionnaire pour stocker les jeux de chaque sous espace
                    var jeuxParSousEspace: [Int: [Jeu]] = [:]

                    // Parcourir la réponse et ajouter les jeux à leur sous espace correspondant
                    for jeuSousEspace in response {
                        if jeuxParSousEspace[jeuSousEspace.sousEspaceDeJeuID] == nil {
                            jeuxParSousEspace[jeuSousEspace.sousEspaceDeJeuID] = [jeuSousEspace.jeu]
                        } else {
                            jeuxParSousEspace[jeuSousEspace.sousEspaceDeJeuID]?.append(jeuSousEspace.jeu)
                        }
                    }
                    
                    self.sousEspacesJeux = jeuxParSousEspace
                                        
                    self.state = .success
                    
                    //print("Dictionnaire")
                    //print(self.sousEspacesJeux)
                    
                    
                } catch {
                    self.state = .error("Impossible de décoder la réponse")
                }
            }
        }.resume()
    }

}
