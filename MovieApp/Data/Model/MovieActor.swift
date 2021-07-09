//
//  MovieActor.swift
//  MovieApp
//
//  Created by Tuan Le on 04/07/2021.
//

import Foundation

// MARK: - MovieActor
struct MovieActor: Codable {
    let cast, crew: [CastActor]
    let id: Int
}

// MARK: - Cast
struct CastActor: Codable {
    let character: String?
    let creditID, releaseDate: String
    let voteCount: Int
    let video, adult: Bool
    let voteAverage: Double
    let title: String
    let genreIDS: [Int]
    let originalLanguage: OriginalLanguage
    let originalTitle: String
    let popularity: Double
    let id: Int
    let backdropPath: String?
    let overview: String
    let posterPath: String?
    let department: Department?
    let job: Job?

    enum CodingKeys: String, CodingKey {
        case character
        case creditID = "credit_id"
        case releaseDate = "release_date"
        case voteCount = "vote_count"
        case video, adult
        case voteAverage = "vote_average"
        case title
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case popularity, id
        case backdropPath = "backdrop_path"
        case overview
        case posterPath = "poster_path"
        case department, job
    }
}

enum Department: String, Codable {
    case production = "Production"
}

enum Job: String, Codable {
    case executiveProducer = "Executive Producer"
    case producer = "Producer"
}

enum OriginalLanguage: String, Codable {
    case en = "en"
}
