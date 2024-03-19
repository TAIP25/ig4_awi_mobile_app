//
//  SignupViewModel.swift
//  test
//
//  Created by etud on 18/03/2024.
//

import SwiftUI

struct SignupResponse: Codable {
    let benevole: Benevole
    let message: String
    let severity: String
}


class SignupViewModel: ObservableObject{
    
    @Published var prenom : String = ""
    @Published var nom : String = ""
    @Published var email : String = ""
    @Published var pseudo : String = ""
    @Published var password : String = ""
    @Published var confirmPassword : String = ""
    
    @Published var message : String = ""
    @Published var state : SignupState = .idle
    

    func signup(){
        
    
        
        state = .loading
        
        guard !email.isEmpty, !password.isEmpty, !prenom.isEmpty,
        !nom.isEmpty, !pseudo.isEmpty, !confirmPassword.isEmpty
        else {
            state = .failure(NSError(domain: "", code: 0, userInfo: nil))
            return
        }
        
        guard password == confirmPassword else {
            state = .failure(NSError(domain: "", code: 0, userInfo: nil))
            return
        }
        
        let url = URL(string: "https://festival-du-jeu-api.onrender.com/benevole")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = ["prenom": prenom, "nom": nom ,"email": email, "pseudo": pseudo, "password": password]
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
                    self.state = .failure(NSError(domain: "", code:0, userInfo: nil))
                    return
                }

                do {
                    let decoder = JSONDecoder()

                    print(String(data: data, encoding: .utf8) ?? "No data")

                    let response = try decoder.decode(SignupResponse.self, from: data)

                    self.message = response.message
                    self.state = .success
                    
                } catch {
                    self.state = .failure(error)
                }
            }
        }.resume()
        
    }
}
