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
        case planning
    }

    @Published var navPath = NavigationPath()

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
