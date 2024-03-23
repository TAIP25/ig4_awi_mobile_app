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
        
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath){
                LoginView(viewModel: login)
                    .navigationDestination(for: Router.Destination.self){
                        destination in switch destination{
                        case .login:
                            LoginView(viewModel: login)
                        case .signup:
                            SignupView(viewModel: signup, destination: destination)
                        case .home:
                            HomeView(festivalVM: festivalVM)
                        case .planning:
                            PlanningView()
                        case .festivalRegister:
                            FestivalRegisterView(viewModel: festivalRegisterVM, festivalVM: festivalVM)
                        }
                    
                    }
            }
            .environmentObject(router)
            
        }
    }
}
