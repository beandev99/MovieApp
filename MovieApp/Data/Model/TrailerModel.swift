//
//  TrailerModel.swift
//  MovieApp
//
//  Created by Tuan Le on 13/06/2021.
//

import Foundation

struct TrailerModel: Codable {
    let id: Int
    let results: [ResultTrailer]
    var urlYoutube: String?
}

// MARK: - Result
struct ResultTrailer: Codable {
    let id, iso639_1, iso3166_1, key: String
    let name, site: String
    let size: Int
    let type: String

    enum CodingKeys: String, CodingKey {
        case id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case key, name, site, size, type
    }
}
