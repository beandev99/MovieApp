//
//  LinkMovie.swift
//  MovieApp
//
//  Created by Tuan Le on 19/06/2021.
//

import Foundation

// MARK: - LinkMovie
struct LinkMovie: Codable {
    let data: DataClass
    let message: String
}

// MARK: - DataClass
struct DataClass: Codable {
    let id, dataID: String
    let v: Int
    let episodeID: String
    let linkSub: String
    let name, slug: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case dataID = "id"
        case v = "__v"
        case episodeID = "episode_id"
        case linkSub = "link_sub"
        case name, slug, url
    }
}
