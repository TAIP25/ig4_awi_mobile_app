//
//  ProfileView.swift
//  test
//
//  Created by etud on 25/03/2024.
//

import Foundation

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel : ProfileViewModel
    
    @EnvironmentObject var router: Router
    
    @State var alertIsOpened : Bool = false
    @State var isEditing : Bool = false // état pour suivre si les champs sont activés ou non

    
    let logo = UIImage(named: "logo_vectorise")
    

    var body: some View {
        
        
        
        VStack {
            Image(uiImage: logo!)
                .resizable()
                .frame(width: 256, height: 151)
            
            Spacer()
            
            TextField("Prénom", text: $viewModel.prenom)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding()
                .background(Color.white)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .cornerRadius(5)
                .hoverEffect()
                .disabled(!isEditing) // Désactive le champ lorsque isEditing est false
                .opacity(isEditing ? 1.0 : 0.5) // Grise le champ lorsque isEditing est false


            
            TextField("Nom", text: $viewModel.nom)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding()
                .background(Color.white)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .cornerRadius(5)
                .hoverEffect()
                .disabled(!isEditing) // Désactive le champ lorsque isEditing est false
                .opacity(isEditing ? 1.0 : 0.5) // Grise le champ lorsque isEditing est false


            
            TextField("Email", text: $viewModel.email)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding()
                .background(Color.white)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .cornerRadius(5)
                .hoverEffect()
                .disabled(!isEditing) // Désactive le champ lorsque isEditing est false
                .opacity(isEditing ? 1.0 : 0.5) // Grise le champ lorsque isEditing est false


            
            TextField("Pseudo", text: $viewModel.pseudo)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding()
                .background(Color.white)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .cornerRadius(5)
                .hoverEffect()
                .disabled(!isEditing) // Désactive le champ lorsque isEditing est false
                .opacity(isEditing ? 1.0 : 0.5) // Grise le champ lorsque isEditing est false


            
            Spacer()
            
            HStack{
                
                Button(action: {
                    isEditing = true // Active les champs lorsque le bouton "Editer" est pressé
                }
                    ) {
                    Text("Editer")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(5)
                }
                
                Button(action: {
                    viewModel.updateBenevoleData()
                }
                    ) {
                    Text("Valider")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(5)
                }
                
                
            }
            
            
            switch viewModel.state {
                
            case .failure(let error):
                Text("Impossible de mettre à jour les données: \(error)")
                
                
            default:
                EmptyView()
                
            }
        }
        .padding()
        .onAppear(){
            viewModel.fetchBenevoleData()
        }
        .alert("Données modifiées avec succès !", isPresented: $alertIsOpened){
            
        }
        .onChange(of: viewModel.state){ oldState, newState in
            if case .success = newState{
                viewModel.fetchBenevoleData()
                self.alertIsOpened = true
                isEditing = false // Désactive les champs lorsque le state est à success
            }
        }

    }
    
}
