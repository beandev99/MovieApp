// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieModel = try? newJSONDecoder().decode(MovieModel.self, from: jsonData)

import Foundation

// MARK: - MovieModel
struct MovieModel: Codable {
    var page: Int
    var results: [Result]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Result: Codable {
    let firstAirDate: String?
    let originalLanguage: String?
    let id: Int?
    let name: String?
    let voteAverage: Double?
    let overview: String?
    let voteCount: Int?
    let posterPath: String?
    let originalName: String?
    let backdropPath: String?
    let originCountry: [String]?
    let genreIDS: [Int]?
    let popularity: Double?
    let mediaType: MediaType?
    let originalTitle: String?
    let video: Bool?
    let releaseDate, title: String?
    let adult: Bool?

    enum CodingKeys: String, CodingKey {
        case firstAirDate = "first_air_date"
        case originalLanguage = "original_language"
        case id, name
        case voteAverage = "vote_average"
        case overview
        case voteCount = "vote_count"
        case posterPath = "poster_path"
        case originalName = "original_name"
        case backdropPath = "backdrop_path"
        case originCountry = "origin_country"
        case genreIDS = "genre_ids"
        case popularity
        case mediaType = "media_type"
        case originalTitle = "original_title"
        case video
        case releaseDate = "release_date"
        case title, adult
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
    case person = "person"
}

//enum OriginalLanguage: String, Codable {
//    case en = "en"
//    case fr = "fr"
//    case ja = "ja"
//    case ko = "ko"
//    case hi = "hi"
//    case es = "es"
//    case pt = "pt"
//    case it = "it"
//    case ru = "ru"
//    case tr = "tr"
//}
