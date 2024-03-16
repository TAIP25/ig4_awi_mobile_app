import Combine

class CreneauHoraireViewModel: ObservableObject {
    
    @Published private(set) var viewState: ViewState
    private var state: State

    private let service: CreneauHoraireService

    init(service: CreneauHoraireService) {
        self.service = service
        self.state = State()
        self.viewState = ViewState(isLoading: false, errorMessage: nil, creneauxHoraires: [], selectedCreneauHoraire: nil, selectedDay: Day.samedi)
    }

    func process(intent: Intent) {
        switch intent {
        case .loadCreneauxHoraires:
            viewState.isLoading = true
            service.fetchCreneauxHoraires { [weak self] result in
                guard let self = self else { return }
                self.viewState.isLoading = false
                switch result {
                case .success(let creneauxHoraires):
                    self.state.creneauxHoraires = creneauxHoraires
                    self.viewState.creneauxHoraires = creneauxHoraires
                case .failure(let error):
                    self.viewState.errorMessage = error.localizedDescription
                }
            }
        case .changeDay:
            viewState.selectedDay = viewState.selectedDay == .dimanche ? .samedi : .dimanche
        case .selectCreneauHoraire(let creneauHoraire):
            state.selectedCreneauHoraire = creneauHoraire
            viewState.selectedCreneauHoraire = creneauHoraire
        }
    }
}

