//
//  MovieDetails.swift
//  MovieApp
//
//  Created by Ramesh on 27/02/19.
//  Copyright © 2019 Ramesh. All rights reserved.
//

import UIKit

class MovieDetails : Codable {
    
    var id: Int64
    var imdbID: String?
    var adult: Bool
    var backdropPath: String?
    var budget: Decimal
    var genres: [Genres]
    var homepage: String?
    var originalLanguage: String?
    var originalTitle: String?
    var overview : String?
    var popularity: Decimal
    var posterPath: String?
    var productionCompanies: [Company]
    var productionCountries: [Country]
    var releaseDate : String?
    var revenue : Decimal
    var runtime : Int?
    var spokenLanguages: [Language]
    var status: String?
    var tagline: String?
    var title: String
    var video: Bool
    var voteAverage: Double
    var voteCount: Int64
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case imdbID  = "imdb_id"
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case budget = "budget"
        case genres = "genres"
        case homepage = "homepage"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue = "revenue"
        case runtime = "runtime"
        case spokenLanguages = "spoken_languages"
        case status = "status"
        case tagline = "tagline"
        case title = "title"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
