//
//  PlanningViewModel.swift
//  test
//
//  Created by etud on 23/03/2024.
//

import Foundation



struct KeyInscription: Hashable{
    let creneauId: Int
    let postId: Int
}

struct CreneauHoraireResponse: Codable {
    let creneauHoraire: [CreneauHoraire]
    let message: String
    let severity: String
}

struct PosteResponse: Codable {
    let postes: [Poste]
    let message: String
    let severity: String
}

struct InscriptionBenevoleResponse: Codable{
    let inscription: [InscriptionBenevoleCount]
    let message : String
    let severity : String
}

struct MesInscriptionsBenevoleResponse: Codable{
    let inscription: [MonInscriptionBenevole]
    let message : String
    let severity : String
}

class PlanningViewModel: ObservableObject {
    
    @Published var texte = "réservé"
    @Published var state: PlanningState = .loading
    
    @Published var days : [String] = ["Samedi", "Dimanche"]
    @Published var selectedDay: String = "Samedi"
    @Published var selectedPost: Poste?
    
    
    @Published var creneauxHoraires: [CreneauHoraire] = []
    @Published var postes: [Poste] = []
    
    @Published var selectedCreneauxHoraires: [CreneauHoraire] = []
    @Published var selectedCreneauHoraire: CreneauHoraire?

    @Published var filteredCreneauxHoraires: [CreneauHoraire] = []
    
    //@Published var inscriptionBenevole: [InscriptionBenevole] = []
    @Published var inscriptionBenevole: [KeyInscription: InscriptionBenevole] = [:]

    @Published var mesInscriptionsBenevole: [MonInscriptionBenevole] = []
    
    let user = UserDefaults.standard.data(forKey: "benevole")


    func fetchCreneauxHoraires(festivalId: Int) {
        state = .loading
        
        let url = URL(string: "https://festival-du-jeu-api.onrender.com/creneauHoraire")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async { // Déplacez tout le code suivant sur le thread principal
                if let _error = error {
                    self.state = .error("Erreur")
                    return
                }
                
                
                guard let data = data else {
                    self.state = .error("Erreur")
                    return
                }
                
                
                do {
                    let decoder = JSONDecoder()
                                        
                    let response = try decoder.decode(CreneauHoraireResponse.self, from: data)
                    self.creneauxHoraires = response.creneauHoraire
                    self.filterCreneauxHoraires()
                    self.fetchInscriptionBenevole(festivalId: festivalId)
                    
                } catch {
                    self.state = .error("error")
                }
            }
        }.resume()
    }
    
    func fetchPostes(festivalId: Int) {
        state = .loading
        
        let url = URL(string: "https://festival-du-jeu-api.onrender.com/poste/festival/\(festivalId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async { // Déplacez tout le code suivant sur le thread principal
                if let _error = error {
                    self.state = .error("Erreur")
                    return
                }
                
                guard let data = data else {
                    self.state = .error("Erreur")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                                        
                    let response = try decoder.decode(PosteResponse.self, from: data)
                    
                    self.postes = response.postes
                    
                } catch {
                    self.state = .error("error")
                }
            }
        }.resume()
    }
    
    func fetchInscriptionBenevole(festivalId: Int) {
        state = .loading
        
        let url = URL(string: "https://festival-du-jeu-api.onrender.com/inscriptionBenevole/festival/\(festivalId)/count")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async { // Déplacez tout le code suivant sur le thread principal
                if let error = error {
                    self.state = .error("Erreur")
                    return
                }
                
                
                guard let data = data else {
                    self.state = .error("Erreur")
                    return
                }
                
                
                do {
                    let decoder = JSONDecoder()
                                        
                    let response = try decoder.decode(InscriptionBenevoleResponse.self, from: data)
                    
                    //Fais le ici
//                    self.inscriptionBenevole = self.mapInscriptionBenevoleData(inscriptionBenevoleCount: response.inscription, creneauxHoraires: self.creneauxHoraires, postes: self.postes)

                    self.inscriptionBenevole = self.mapInscriptionBenevoleData(inscriptionBenevoleCount: response.inscription, creneauxHoraires: self.creneauxHoraires, postes: self.postes)

                    
                } catch {
                    self.state = .error("error")
                }
            }
        }.resume()
    }
    
    func fetchMyInscriptionBenevole(festivalId: Int) {
        state = .loading
        
        let benevole : Benevole = try! JSONDecoder().decode(Benevole.self, from: user!)
        
        
        let url = URL(string: "https://festival-du-jeu-api.onrender.com/inscriptionBenevole/festival/\(festivalId)/benevole/\(benevole.id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async { // Déplacez tout le code suivant sur le thread principal
                if let error = error {
                    self.state = .error("Erreur")
                    return
                }
                
                
                guard let data = data else {
                    self.state = .error("Erreur")
                    return
                }
                
                do {
                    let decoder = JSONDecoder();
                    print(String(data: data, encoding: .utf8) ?? "No data")
                    print(decoder)
                    let response = try decoder.decode(MesInscriptionsBenevoleResponse.self, from: data)
                    self.mesInscriptionsBenevole = response.inscription
                    print("aled")
                    print("ffefsf");
                    // rip

                } catch {
                    self.state = .error("error")
                }
            }
        }.resume()
    }
    
    
    func handleReservation(festivalId: Int, posteId: Int, creneauHoraireId: Int) {
        
        print("AHAHAHHAHAHAHAHAHAH")
        
        state = .loading
        
        let benevole : Benevole = try! JSONDecoder().decode(Benevole.self, from: user!)

        
        let url = URL(string: "https://festival-du-jeu-api.onrender.com/inscriptionBenevole")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = UserDefaults.standard.string(forKey: "token") {
            // Ajouter le token d'authentification au dictionnaire des en-têtes
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let parameters: [String: Any] = ["benevoleID": benevole.id, "festivalID": festivalId ,"creneauHoraireID": creneauHoraireId, "posteID": posteId]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            state = .error("Erreur")
            return
        }

        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async { // Déplacez tout le code suivant sur le thread principal
                if let _error = error {
                    self.state = .error("Erreur")
                    return
                }
                
                
                guard let data = data else {
                    self.state = .error("Erreur")
                    return
                }
                
                
                do {
                    let decoder = JSONDecoder()
                                        
                    let _response = try decoder.decode(InscriptionBenevoleResponse.self, from: data)
                    
                    self.fetchMyInscriptionBenevole(festivalId: festivalId)
                    self.fetchInscriptionBenevole(festivalId: festivalId)
                    
                    
                    
                } catch {
                    self.state = .error("error")
                }
            }
        }.resume()
    }
    
    func handleAnnulerReservation(festivalId: Int, posteId: Int, creneauHoraireId: Int) {
        state = .loading
        
        let _benevole : Benevole = try! JSONDecoder().decode(Benevole.self, from: user!)
        
        let reservation = mesInscriptionsBenevole.first(where: { $0.posteID == posteId && $0.creneauHoraireID == creneauHoraireId })
        
        
        let url = URL(string: "https://festival-du-jeu-api.onrender.com/inscriptionBenevole/\(reservation!.id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = UserDefaults.standard.string(forKey: "token") {
            // Ajouter le token d'authentification au dictionnaire des en-têtes
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        

        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async { // Déplacez tout le code suivant sur le thread principal
                if let _error = error {
                    self.state = .error("Erreur")
                    return
                }
                
                
                guard let data = data else {
                    self.state = .error("Erreur")
                    return
                }
                
                
                do {
                    let decoder = JSONDecoder()
                                        
                    let _response = try decoder.decode(InscriptionBenevoleResponse.self, from: data)
                    
                    self.fetchMyInscriptionBenevole(festivalId: festivalId)
                    
                    
                    
                } catch {
                    self.state = .error("error")
                }
            }
        }.resume()
    }
    
    
    
    func getMonInscriptionBenevole(posteID: Int, creneauHoraireID: Int) -> MonInscriptionBenevole? {
        return mesInscriptionsBenevole.first(where: { $0.posteID == posteID && $0.creneauHoraireID == creneauHoraireID })
    }


    
    func filterCreneauxHoraires() {
        filteredCreneauxHoraires = creneauxHoraires.filter { $0.jour == selectedDay }
    }
    
//    func mapInscriptionBenevoleData(inscriptionBenevoleCount: [InscriptionBenevoleCount], creneauxHoraires: [CreneauHoraire], postes: [Poste]) -> [InscriptionBenevole] {
//        var inscriptionBenevoles: [InscriptionBenevole] = []
//        
//        for inscription in inscriptionBenevoleCount {
//            let poste = self.postes.first(where: { $0.id == inscription.posteID })
//
//            let nombreMax = poste?.nombreBenevoles ?? 1
//            let inscriptionBenevole = InscriptionBenevole(posteID: inscription.posteID, creneauHoraireID: inscription.creneauHoraireID, nombreInscrits: inscription._count.id, nombreMax: nombreMax)
//
//            inscriptionBenevoles.append(inscriptionBenevole)
//        }
//        
//        var i = 0
//        for creneau in creneauxHoraires {
//                for poste in postes {
//                    let newInscription = InscriptionBenevole(posteID: poste.id, creneauHoraireID: creneau.id, nombreInscrits: 0, nombreMax: poste.nombreBenevoles)
//                    if !inscriptionBenevoles.contains(where: { $0.posteID == newInscription.posteID && $0.creneauHoraireID == newInscription.creneauHoraireID }) {
//                        i += 1
//                        inscriptionBenevoles.append(newInscription)
//                    }
//                }
//            }
//        
//
//        return inscriptionBenevoles
//    }
    
    func mapInscriptionBenevoleData(inscriptionBenevoleCount: [InscriptionBenevoleCount], creneauxHoraires: [CreneauHoraire], postes: [Poste]) -> [KeyInscription: InscriptionBenevole] {
        var inscriptionBenevoles: [KeyInscription: InscriptionBenevole] = [:]

        for inscription in inscriptionBenevoleCount {
            let poste = self.postes.first(where: { $0.id == inscription.posteID })

            let nombreMax = poste?.nombreBenevoles ?? 1
            let inscriptionBenevole = InscriptionBenevole(posteID: inscription.posteID, creneauHoraireID: inscription.creneauHoraireID, nombreInscrits: inscription._count.id, nombreMax: nombreMax)

            let key = KeyInscription(creneauId: inscription.creneauHoraireID, postId: inscription.posteID)
            inscriptionBenevoles[key] = inscriptionBenevole
        }

        for creneau in creneauxHoraires {
            for poste in postes {
                let newInscription = InscriptionBenevole(posteID: poste.id, creneauHoraireID: creneau.id, nombreInscrits: 0, nombreMax: poste.nombreBenevoles)
                let key = KeyInscription(creneauId: creneau.id, postId: poste.id)
                if inscriptionBenevoles[key] == nil {
                    inscriptionBenevoles[key] = newInscription
                }
            }
        }

        return inscriptionBenevoles
    }

    
//    func getInscriptionBenevole(posteID: Int, creneauHoraireID: Int) -> InscriptionBenevole? {
//        return inscriptionBenevole.first(where: { $0.posteID == posteID && $0.creneauHoraireID == creneauHoraireID })
//    }




    
}
