import Foundation

protocol DataProvider {
    func fetchData(with url: URL, completion: @escaping (Result<Data, Error>) -> Void) -> SessionDataTask
}

protocol SessionDataTask {
    func resume()
    func cancel()
}

extension URLSessionDataTask: SessionDataTask {}

enum NetworkingError: Error {
    case unknownError
}

struct NetworkClient: DataProvider {

    private let session = URLSession.shared

    func fetchData(
        with url: URL,
        completion: @escaping (Result<Data, Error>) -> Void
    ) -> SessionDataTask {

        session.dataTask(with: url) { data, _, error in

            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(NetworkingError.unknownError))
            }
        }
    }
}
