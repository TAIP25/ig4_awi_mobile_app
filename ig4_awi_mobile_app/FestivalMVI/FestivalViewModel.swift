//
//  FestivalViewModel.swift
//  test
//
//  Created by etud on 22/03/2024.
//

import Foundation

class FestivalViewModel: ObservableObject{
    
    @Published var state: FestivalState = .initial
    
    @Published var festival : Festival? = nil
    
    func fetchNextFestival() {
        state = .loading
        
        let url = URL(string: "https://festival-du-jeu-api.onrender.com/festival/next")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async { // Déplacez tout le code suivant sur le thread principal
                if let error = error {
                    self.state = .error(error)
                    return
                }
                
                
                guard let data = data else {
                    self.state = .error(NSError(domain: "", code: 0, userInfo: nil))
                    return
                }
                
                
                do {
                    let decoder = JSONDecoder()
                    
                    print(String(data: data, encoding: .utf8) ?? "No data")
                    
                    let response = try decoder.decode(Festival.self, from: data)
                    self.state = .loaded(response)
                    self.festival = response
                    
                    
                } catch {
                    self.state = .error(error)
                }
            }
        }.resume()}
    
    func isRegisterToFestival(festivalID: Int, benevoleID: Int){
        
        let url = URL(string: "https://festival-du-jeu-api.onrender.com/festivalBenevole/\(festivalID)/\(benevoleID)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async { // Déplacez tout le code suivant sur le thread principal
                if let error = error {
                    self.state = .error(error)
                    return
                }
                
                
                guard let data = data else {
                    self.state = .error(NSError(domain: "", code: 0, userInfo: nil))
                    return
                }
                
                
                do {
                    let decoder = JSONDecoder()
                    
                    print(String(data: data, encoding: .utf8) ?? "No data")
                    
                    let response = try decoder.decode(FestivalBenevole.self, from: data)
                    self.state = .isRegister
                    
                } catch {
                    self.state = .error(error)
                }
            }
        }.resume()}
}
