//
//  Movies.swift
//  exercise2films
//
//  Created by David on 17/9/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movies = try? newJSONDecoder().decode(Movies.self, from: jsonData)

import Foundation

class Movies: Codable {
    let search: [Search]?
    let totalResults, response: String?

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }

    init(search: [Search]?, totalResults: String?, response: String?) {
        self.search = search
        self.totalResults = totalResults
        self.response = response
    }
}

// MARK: - Search
class Search: Codable {
    let title, year, imdbID: String?
    let type: TypeEnum?
    let poster: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }

    init(title: String?, year: String?, imdbID: String?, type: TypeEnum?, poster: String?) {
        self.title = title
        self.year = year
        self.imdbID = imdbID
        self.type = type
        self.poster = poster
    }
}

enum TypeEnum: String, Codable {
    case movie = "movie"
}

