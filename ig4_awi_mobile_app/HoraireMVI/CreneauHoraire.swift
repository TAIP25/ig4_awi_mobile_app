import Combine

struct CreneauHoraire: Codable {
    let id: Int
    let jour: String
    let heureDebut: Int
    let heureFin: Int
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case jour
        case heureDebut
        case heureFin
        case createdAt
        case updatedAt
    }
    
}

enum Day: String, CaseIterable {
    case samedi = "Samedi"
    case dimanche = "Dimanche"
}


class AppViewModel: ObservableObject {
    let creneauHoraireViewModel: CreneauHoraireViewModel

    init() {
        let service = CreneauHoraireService()
        self.creneauHoraireViewModel = CreneauHoraireViewModel(service: service)
    }
}
