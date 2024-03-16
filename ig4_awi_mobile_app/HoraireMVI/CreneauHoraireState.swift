enum Intent {
    case loadCreneauxHoraires
    case changeDay
    case selectCreneauHoraire(CreneauHoraire)
}

struct State {
    var creneauxHoraires: [CreneauHoraire] = []
    var selectedCreneauHoraire: CreneauHoraire?
}

struct ViewState {
    var isLoading: Bool
    var errorMessage: String?
    var creneauxHoraires: [CreneauHoraire]
    var selectedCreneauHoraire: CreneauHoraire?
    var selectedDay: Day
}
