import Alamofire
import Foundation

class NetworkClient {
    private let baseUrl = "https://gateway.marvel.com"
    private let charactersPath = "/v1/public/characters"
    private let comicsPath = "/v1/public/comics"

    private lazy var timestamp: Int = {
        return Int(Date().timeIntervalSince1970)
    }()

    // HASH de la API de Marvel
    // (e.g. md5(ts+privateKey+publicKey)
    private lazy var hash: String = {
        return md5Hash("\(timestamp)\(privateKey)\(publicKey)")
    }()

    func getCharacters(offset: Int, completion: @escaping (Result<CharacterResponse, NetworkError>) -> Void) {
        AF.request(
            "\(baseUrl)\(charactersPath)",
            method: .get,
            parameters: [
                "apikey": publicKey,
                "hash": hash,
                "ts": timestamp,
                "limit": 100,
                "offset": offset
            ]
        ).validate(statusCode: 200 ..< 299).responseJSON { serverResponse in
            guard serverResponse.error == nil else {
                completion(.failure(.serverError("Ha ocurrido algun error: \(serverResponse.error?.localizedDescription ?? "")")))
                return
            }
            guard let secureData = serverResponse.data else {
                completion(.failure(.dataError("Ha ocurrido algun error y los datos no existen")))
                return
            }
            do {
                let json = try JSONDecoder().decode(CharacterResponse.self, from: secureData)
                completion(.success(json))
            } catch {
                completion(.failure(.serializationError("Error: \(error.localizedDescription)")))
                return
            }
        }
    }
}

enum NetworkError: Error, LocalizedError {
    case serverError(String)
    case dataError(String)
    case serializationError(String)

    public var errorDescription: String? {
        switch self {
        case .serverError(let descrition):
            return descrition
        case .dataError(let descrition):
            return descrition
        case .serializationError(let descrition):
            return descrition
        }
    }
}
