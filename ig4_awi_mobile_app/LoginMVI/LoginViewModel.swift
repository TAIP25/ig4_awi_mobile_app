//
//  LoginViewModel.swift
//  ig4_awi_mobile_app
//
//  Created by etud on 13/03/2024.
//

import SwiftUI

struct LoginResponse: Codable {
    let benevole: Benevole
    let message: String
    let token: String
    let severity: String
}

struct Benevole: Codable {
    let id: Int
    let nom: String
    let prenom: String
    let email: String
    let password: String
    let pseudo: String
    let tailleTShirt: String?
    let vegetarien: Bool?
    let hebergement: String?
    let gameFavori: Int?
    let picture: Int?
    let associationID: Int?
    let adresse: String?
    let telephone: String?
    let createdAt: Date
    let updatedAt: Date
    // Ajoutez d'autres propriétés du bénévole si nécessaire
}

class LoginViewModel: ObservableObject {
    

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var state: LoginState = .idle
    
    @Published var message : String = ""
    @Published var token : String = ""
    

    func login() {
        state = .loading

        guard !email.isEmpty, !password.isEmpty else {
            state = .failure(NSError(domain: "", code: 0, userInfo: nil))
            return
        }

        let url = URL(string: "https://festival-du-jeu-api.onrender.com/benevole/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: Any] = ["email": email, "password": password]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            state = .failure(error)
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.state = .failure(error)
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.state = .failure(NSError(domain: "", code: 0, userInfo: nil))
                }
                return
            }

            do {
                // Ici, vous pouvez décoder la réponse du serveur si nécessaire
                // Par exemple, si le serveur renvoie un jeton d'authentification
                print("Ici")
                let decoder = JSONDecoder()
                        do {
                            let response = try decoder.decode(LoginResponse.self, from: data)
                            let defaults = UserDefaults.standard
                            let benevole : Benevole  = response.benevole
                            defaults.set(benevole, forKey: "benevole")
                            self.message = response.message
                            self.token = response.token
                            self.state = .success
                        } catch {
                            self.state = .failure(error)
                        }
                

                DispatchQueue.main.async {
                    self.state = .success
                }
            } catch {
                DispatchQueue.main.async {
                    self.state = .failure(error)
                }
            }
        }.resume()
    }
}

