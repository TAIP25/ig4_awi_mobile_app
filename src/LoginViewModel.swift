//
//  LoginViewModel.swift
//  ig4_awi_mobile_app
//
//  Created by etud on 13/03/2024.
//

import Foundation

class LoginViewModel: ObservableObject {

    @Published var username: String = ""
    @Published var password: String = ""

    func login() {
         // Login successful, navigate to the Home screen
        
    }
}
