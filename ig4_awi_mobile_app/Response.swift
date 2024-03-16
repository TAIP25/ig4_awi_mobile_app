struct Response: Codable {
    let creneauHoraire: [CreneauHoraire]
    let message: String
    let severity: String
}
