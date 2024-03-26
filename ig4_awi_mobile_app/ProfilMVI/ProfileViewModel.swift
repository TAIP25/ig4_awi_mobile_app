//
//  ProfileViewModel.swift
//  test
//
//  Created by etud on 18/03/2024.
//

import SwiftUI




class ProfileViewModel: ObservableObject{
    
    @Published var prenom : String = ""
    @Published var nom : String = ""
    @Published var email : String = ""
    @Published var pseudo : String = ""
    
    @Published var message : String = ""
    @Published var state : ProfileState = .idle
    
    let user = UserDefaults.standard.data(forKey: "benevole")

    

    func fetchBenevoleData(){
        
        let benevole : Benevole = try! JSONDecoder().decode(Benevole.self, from: user!)

        
        state = .loading
        
        
        let url = URL(string: "https://festival-du-jeu-api.onrender.com/benevole/\(benevole.id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async { // Déplacez tout le code suivant sur le thread principal
                if let error = error {
                    self.state = .failure("Erreur")
                    return
                }

                guard let data = data else {
                    self.state = .failure("Erreur")
                    return
                }

                do {
                    let decoder = JSONDecoder()

                    print(String(data: data, encoding: .utf8) ?? "No data")

                    let response = try decoder.decode(Benevole.self, from: data)

                    self.prenom = response.prenom
                    self.nom = response.nom
                    self.email = response.email
                    self.pseudo = response.pseudo
                    
                } catch {
                    self.state = .failure("Erreur")
                }
            }
        }.resume()
        
    }
    
    func updateBenevoleData(){
        
        let benevole : Benevole = try! JSONDecoder().decode(Benevole.self, from: user!)

        
        state = .loading
        
        
        let url = URL(string: "https://festival-du-jeu-api.onrender.com/benevole/\(benevole.id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = UserDefaults.standard.string(forKey: "token") {
            // Ajouter le token d'authentification au dictionnaire des en-têtes
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let parameters: [String: Any] = ["prenom": prenom, "nom": nom ,"email": email, "pseudo": pseudo]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            state = .failure("Impossible d'encoder les champs")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async { // Déplacez tout le code suivant sur le thread principal
                if let error = error {
                    self.state = .failure("Erreur serveur")
                    return
                }

                guard let data = data else {
                    self.state = .failure("Erreur récupération des données")
                    return
                }

                do {
                    let decoder = JSONDecoder()

                    print(String(data: data, encoding: .utf8) ?? "No data")

                    let response = try decoder.decode(Benevole.self, from: data)

                    self.state = .success
                    
                } catch {
                    self.state = .failure("Impossible de décoder la réponse du servuer")
                }
            }
        }.resume()
        
    }
}
