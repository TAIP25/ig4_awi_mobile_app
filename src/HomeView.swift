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

            Button("Edit") {
                router.navigate(to: .edit)
            }
            .padding(.top, 12)

            Button("View") {
                router.navigate(to: .view)
            }
            .padding(.top, 12)

            Button("Tracks") {
                router.navigate(to: .tracks)
            }
            .padding(.top, 12)

        }
        .padding()
    }
}
