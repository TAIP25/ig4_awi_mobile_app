import SwiftUI

struct FestivalRegisterView: View {

    @ObservedObject var viewModel: FestivalRegisterViewModel
    
    @ObservedObject var festivalVM: FestivalViewModel
    
    @EnvironmentObject var router: Router

    
    let tShirtSizes = ["XS", "S", "M", "L", "XL", "XXL"]
    let hebergement = ["Recherche", "Proposition", "Aucun"]

    var body: some View {
        VStack {
            if let festival = festivalVM.festival {
                Text("Inscription au festival édition \(festival.edition) ")
            } else {
                Text("Chargement...")
            }
            
            Picker("Taille du t-shirt", selection: $viewModel.selectedTShirtSize) {
                ForEach(tShirtSizes, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(DefaultPickerStyle())
            
            Picker("Hébergement", selection: $viewModel.selectedHebergement) {
                ForEach(hebergement, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(DefaultPickerStyle())
            
            if viewModel.selectedHebergement == "Proposition" {
                TextField("Adresse postale", text: $viewModel.address)
            }
            
            TextField("Numéro de téléphone", text: $viewModel.phoneNumber)
                .keyboardType(.numberPad)
            
            Toggle("Végétarien", isOn: $viewModel.isVegetarian)
            
            Button(action: {
                viewModel.register( festivalId: festivalVM.festival!.id)
            }) {
                
                Text("S'inscrire")
                    .font(.footnote)
                
                    .foregroundColor(.blue)
            }
            .padding(10)
            .background(.teal.opacity(0.25))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.teal, lineWidth: 1)
            )
            
            switch viewModel.state{
            case .success:
                Text("Inscription réussi")
                
            case .error(let error):
                Text(error)
                
            case .loading:
                Text("Inscription en cours...")
                
            case .initial:
                EmptyView()
                
            }
            
        }
            
        .padding()
        .onAppear {
            self.festivalVM.fetchNextFestival()
        }
        .onChange(of: viewModel.state){ oldState, newState in
            if case .success = newState{
                router.navigateBack()
            }
            
        }


    }
}
