
import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    @EnvironmentObject var router: Router
    
    let logo = UIImage(named: "logo_vectorise")
    
    @State private var errorMessage: String?
    //@State private var state: LoginState?

    var body: some View {
        VStack {
            Image(uiImage: logo!)
                .resizable()
                .frame(width: 256, height: 151)
            
            Spacer()
            
            TextField("Mail", text: $viewModel.email)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding()
                .background(Color.white)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .cornerRadius(5)
                .hoverEffect()
        

            SecureField("Mot de passe", text: $viewModel.password)
                .padding()
                .background(Color.white)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .cornerRadius(5)
            
            Button(action: {
                router.navigate(to: .signup)
                        }) {
                            HStack {
                                Text("Pas de compte ?")
                                    .font(.footnote)
                                Text("Inscrivez-vous !")
                                    .font(.footnote)
                                    .bold()
                            }
                            .foregroundColor(.blue)
                        }
                        .buttonStyle(PlainButtonStyle())
            
            Spacer()
            
            switch viewModel.state {
                    case .success:
                        let defaults = UserDefaults.standard
                        if let user = defaults.data(forKey: "benevole"),
                           let benevole = try? JSONDecoder().decode(Benevole.self, from: user) {
                            Text("La connexion a réussi, connecté en tant que : \(benevole.prenom)")
                                .foregroundColor(.green)
                                .padding()
                        } else {
                            Text("Erreur lors de la récupération des données du bénévole")
                                .foregroundColor(.red)
                                .padding()
                        }
                
                    case .failure(let error):
                        Text("La connexion a échouée : \(error.localizedDescription)")
                            .foregroundColor(.red)
                            .padding()
                
                    case .loading:
                        Text("Authentification en cours...")
                            .padding()
                
                    case .idle:
                        EmptyView() // Ne rien afficher dans ce cas
                    }
            
            
            Button(action: viewModel.login) {
                Text("Se connecter")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(5)
            }
        }
        .padding()
    }
}
