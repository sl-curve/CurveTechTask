import Foundation

struct Movie: Decodable {
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }

    let identifier: Int
    let originalTitle: String
    let overview: String
    let posterPath: String
    let releaseDate: Date
    let voteAverage: Double
}
