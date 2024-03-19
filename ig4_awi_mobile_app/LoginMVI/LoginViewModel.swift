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
            DispatchQueue.main.async { // Déplacez tout le code suivant sur le thread principal
                if let error = error {
                    self.state = .failure(error)
                    return
                }

                guard let data = data else {
                    self.state = .failure(NSError(domain: "", code: 0, userInfo: nil))
                    return
                }

                do {
                    let decoder = JSONDecoder()

                    print(String(data: data, encoding: .utf8) ?? "No data")

                    let response = try decoder.decode(LoginResponse.self, from: data)

                    let defaults = UserDefaults.standard
                    let encoder = JSONEncoder()
                    if let encodedBenevole = try? encoder.encode(response.benevole) {
                        defaults.set(encodedBenevole, forKey: "benevole")
                    }

                    self.message = response.message
                    self.token = response.token

                    self.state = .success
                } catch {
                    self.state = .failure(error)
                }
            }
        }.resume()

    }
}

