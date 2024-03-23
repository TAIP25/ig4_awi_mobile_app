//
//  FestivalRegisterViewModel.swift
//  test
//
//  Created by etud on 21/03/2024.
//

import Foundation
import Combine

struct FestivalBenevoleResponse: Codable {
    let festivalBenevole: FestivalBenevole
    let message: String
    let severity: String
}

class FestivalRegisterViewModel: ObservableObject {
    
    @Published var selectedTShirtSize = "M"
    @Published var selectedHebergement = "Recherche"
    @Published var address = ""
    @Published var phoneNumber = ""
    @Published var isVegetarian = false
    

    @Published var state: FestivalRegisterState = .initial

    let user = UserDefaults.standard.data(forKey: "benevole")
    

    func register(festivalId: Int) {
        
        state = .loading
        
        guard !phoneNumber.isEmpty
        else {
            state = .error("Veuillez renseigner votre numéro de téléphone")
            return
        }
        
        
        let url = URL(string: "https://festival-du-jeu-api.onrender.com/festivalBenevole")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = UserDefaults.standard.string(forKey: "token") {
            // Ajouter le token d'authentification au dictionnaire des en-têtes
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        //On récupère l'id du bénévole
        let benevole : Benevole = try! JSONDecoder().decode(Benevole.self, from: user!)

        print("festivalId:\(festivalId)")
        print("benevoleId:\(benevole.id)")
        let parameters: [String: Int] = ["festivalId": festivalId, "benevoleId": benevole.id]
        do {
            let jsonData = try JSONEncoder().encode(parameters)
            request.httpBody = jsonData
        } catch {
            state = .error("Impossible de soumettre l'inscription")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async { // Déplacez tout le code suivant sur le thread principal
                if let error = error {
                    self.state = .error("Echec de la requête serveur")
                    return
                }

                guard let data = data else {
                    self.state = .error("Pas de réponse serveur")
                    return
                }

                do {
                    let decoder = JSONDecoder()

                    print(String(data: data, encoding: .utf8) ?? "No data")
                    print("LULULU")
                    let response = try decoder.decode(FestivalBenevoleResponse.self, from: data)
                    print("LALALALALALAL")
                    // On met à jour le bénévole avec les données du formulaire
                    self.updateBenevoleInfo(benevolId: benevole.id)
                    print("LOLOLOLO")

                } catch {
                    self.state = .error("Impossible de décoder la réponse")
                    print("Erreur de décodage : \(error)") // Ajoutez cette ligne
                }
            }
        }.resume()
    }
    
    func updateBenevoleInfo(benevolId: Int){
        
        
        let url = URL(string: "https://festival-du-jeu-api.onrender.com/benevole/\(benevolId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = UserDefaults.standard.string(forKey: "token") {
                // Ajouter le token d'authentification au dictionnaire des en-têtes
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        
        let parameters: [String: Any] = ["tailleTShirt": selectedTShirtSize, "hebergement": selectedHebergement, "adresse": address, "telephone": phoneNumber, "vegetarien": isVegetarian]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            state = .error("Impossible de mettre à jour le bénévole")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async { // Déplacez tout le code suivant sur le thread principal
                if let error = error {
                    self.state = .error("error")
                    return
                }

                guard let data = data else {
                    self.state = .error("error")
                    return
                }

                do {
                    let decoder = JSONDecoder()

                    print(String(data: data, encoding: .utf8) ?? "No data")

                    let response = try decoder.decode(Benevole.self, from: data)
                    
                    self.state = .success

                    
                } catch {
                    self.state = .error("error")
                }
            }
        }.resume()
        
        
        
    }

}
