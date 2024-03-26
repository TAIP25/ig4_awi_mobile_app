
import SwiftUI

struct SignupView: View {
    
    @ObservedObject var viewModel : SignupViewModel
    
    @EnvironmentObject var router: Router        
    
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
            
            TextField("Nom", text: $viewModel.nom)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding()
                .background(Color.white)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .cornerRadius(5)
                .hoverEffect()
            
            TextField("Email", text: $viewModel.email)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding()
                .background(Color.white)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .cornerRadius(5)
                .hoverEffect()
            
            TextField("Pseudo", text: $viewModel.pseudo)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding()
                .background(Color.white)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .cornerRadius(5)
                .hoverEffect()
            
            SecureField("Mot de passe", text: $viewModel.password)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding()
                .background(Color.white)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .cornerRadius(5)
                .hoverEffect()
            
            SecureField("Confirmer le mot de passe", text: $viewModel.confirmPassword)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding()
                .background(Color.white)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .cornerRadius(5)
                .hoverEffect()
            
            Spacer()
            
            Button(action: {
                viewModel.signup()
            }
                ) {
                Text("S'inscrire")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(5)
            }
            
            Button(action: {
                router.navigate(to: .login)
                        }) {
                            HStack {
                                Text("Déjà membre ?")
                                    .font(.footnote)
                                Text("Connectez-vous !")
                                    .font(.footnote)
                                    .bold()
                            }
                            .foregroundColor(.blue)
                        }
                        .buttonStyle(PlainButtonStyle())
            
            switch viewModel.state {
            
            case .loading:
                Text("Inscription en cours, vous allez être rediriger vers la page de connexion")
                
            case .failure(let error):
                Text("Impossible de créer un compte: \(error)")
            default:
                EmptyView()
                
            }
        }
        .padding()
        .onChange(of: viewModel.state){ oldState, newState in
            if case .success = newState{
                router.navigateBack()
            }
        }
    }
    
}
