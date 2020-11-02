import Foundation

private let apiKey = "27fa2971af9beb9591da45e709689aa3"

extension URL {
    static func popularMoviesURL(at page: Int, apiKey: String = apiKey) -> URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&page=\(page)") else {
            fatalError("Failure to create popular movies URL")
        }

        return url
    }
}
