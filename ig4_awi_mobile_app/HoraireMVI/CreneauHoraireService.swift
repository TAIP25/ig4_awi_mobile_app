import Foundation

class CreneauHoraireService {
    private let apiUrl = "http://localhost:3000/creneauHoraire"

    func fetchCreneauxHoraires(completion: @escaping (Result<[CreneauHoraire], Error>) -> Void) {
        guard let url = URL(string: apiUrl) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: -1, userInfo: nil)))
                return
            }

            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(response.creneauHoraire))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

