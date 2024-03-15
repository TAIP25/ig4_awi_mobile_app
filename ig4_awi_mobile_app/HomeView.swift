//
//  HomeView.swift
//  ig4_awi_mobile_app
//
//  Created by Léon Boudier on 13/03/2024.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject var router: Router
    var body: some View {
        VStack {
            Image(systemName: "house.fill")
                .font(.system(size: 56))
                .foregroundColor(.accentColor)
            Text("Home")
                .font(.system(size: 24))
            
            Button("Login") {
                router.navigate(to: .login)
            }
            .padding(.top, 12)

        }
        .padding()
    }
}
