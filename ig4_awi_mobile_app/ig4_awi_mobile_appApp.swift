//
//  ig4_awi_mobile_appApp.swift
//  ig4_awi_mobile_app
//
//  Created by Léon Boudier on 13/03/2024.
//

import SwiftUI

@main
struct ig4_awi_mobile_appApp: App {
    
    @ObservedObject var router = Router()
    
    var login = LoginViewModel()
    var signup = SignupViewModel()
    var festivalRegisterVM = FestivalRegisterViewModel()
    var festivalVM = FestivalViewModel()
    var planningVM = PlanningViewModel()
    var profileVM = ProfileViewModel()
    var espaceJeuVM = EspaceJeuxViewModel()
    //var creneauHoraireVM = CreneauHoraireViewModel(service: CreneauHoraireService())
        
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath){
                LoginView(viewModel: login)
                    .navigationDestination(for: Router.Destination.self){
                        destination in switch destination{
                        case .login:
                            LoginView(viewModel: login)
                        case .signup:
                            SignupView(viewModel: signup)
                        case .home:
                            HomeView(festivalVM: festivalVM)
                        case .planning:
                            PlanningView(viewModel: planningVM, festivalVM: festivalVM)
                        case .festivalRegister:
                            FestivalRegisterView(viewModel: festivalRegisterVM, festivalVM: festivalVM)
                        case .profile:
                            ProfileView(viewModel: profileVM)
                        case .espaceJeu:
                            EspaceJeuxView(viewModel: espaceJeuVM, festivalVM: festivalVM)
                        }
                    
                    
                    }
            }
            .environmentObject(router)
            
        }
    }
}
