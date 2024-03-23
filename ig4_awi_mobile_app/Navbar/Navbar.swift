//
//  Navbar.swift
//  test
//
//  Created by etud on 20/03/2024.
//

import SwiftUI

struct NavbarView: View {
    
    let logoHome = UIImage(named: "accueil")
    let logoPlanning = UIImage(named: "planning")
    let logoUser = UIImage(named: "user")

    @EnvironmentObject var router: Router
    
    let user = UserDefaults.standard.data(forKey: "benevole")
    
    var body: some View{
        
        let primary = Color(red: 115/255, green:150/255, blue:0/255);

            HStack() {
                Button(action: {
                    router.navigate(to: .home)
                }) {
                    Image(uiImage: logoHome!)
                        .font(.system(size: 52))
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .overlay(Divider(), alignment: .leading)
                
                Button(action: {
                    router.navigate(to: .planning)
                })
                {
                    Image(uiImage: logoPlanning!)
                        .font(.system(size: 52))
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .overlay(Divider(), alignment: .trailing)
                .overlay(Divider(), alignment: .leading)
                
                Button(action: {
                    router.navigate(to: .home)
                }) {
                    Image(uiImage: logoUser!)
                        .font(.system(size: 52))
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .overlay(Divider(), alignment: .trailing)
            }
            .frame(maxWidth: .infinity)
            .overlay(Rectangle().frame(width: nil, height: 2, alignment: .top).foregroundColor(primary), alignment: .top)
        }
}
