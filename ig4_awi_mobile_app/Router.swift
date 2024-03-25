//
//  Router.swift
//  TP_Mobile
//
//  Created by etud on 15/02/2024.
//

import SwiftUI

final class Router: ObservableObject {

    public enum Destination: Hashable {
        case login
        case signup
        case home
        case planning
        case festivalRegister
        //case creneauHoraire
    }
    

    @Published var navPath = NavigationPath()
    
    @Published var destination : Destination = .signup {
        willSet{
            navigate(to: newValue)
        }
    }

    func navigate(to destination: Destination) {
        navPath.append(destination)
    }

    func navigateBack() {
        navPath.removeLast()
    }

    func navigateToRoot() {
        navPath.removeLast(navPath.count)
        
    }
}
