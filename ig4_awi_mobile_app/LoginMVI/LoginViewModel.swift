//
//  LoginViewModel.swift
//  ig4_awi_mobile_app
//
//  Created by etud on 13/03/2024.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var state: LoginState = .idle

    func login() {
        state = .loading

        // Vérifiez les informations d'identification de l'utilisateur
        guard !email.isEmpty, !password.isEmpty else {
            state = .failure(NSError(domain: "", code: 0, userInfo: nil))
            return
        }

        // Envoyez une requête au serveur pour vérifier les informations d'identification
//        APIClient.shared.login(email: email, password: password) { result in
//            switch result {
//            case .success:
//                state = .success
//            case .failure(let error):
//                state = .failure(error)
//            }
//        }
    }
}
