//
//  Movie.swift
//  MovieApp
//
//  Created by Ramesh on 27/02/19.
//  Copyright © 2019 Ramesh. All rights reserved.
//

import UIKit

class Movie : Codable {

    var id: Int64
    var voateCount: Int64
    var video: Bool
    var voteAverage: Double
    var title: String?
    var popularity: Decimal
    var posterPath: String?
    var originalLanguage: String?
    var originalTitle: String?
    var genreIds: [Int]
    var backDropPath: String?
    var adult: Bool
    var overview: String?
    var releaseDate: String?
    
    init(id :Int64, voateCount: Int64, video: Bool, voteAverage: Double, title: String, popularity: Decimal, posterPath: String, originalLanguage: String, originalTitle: String, genreIds: [Int], backDropPath: String, adult: Bool, overview: String, releaseDate: String) {
        self.id = id
        self.voateCount = voateCount
        self.video = video
        self.voteAverage = voteAverage
        self.title = title
        self.popularity = popularity
        self.posterPath = posterPath
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.genreIds = genreIds
        self.backDropPath = backDropPath
        self.adult = adult
        self.overview = overview
        self.releaseDate = releaseDate
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case voateCount = "vote_count"
        case video = "video"
        case voteAverage = "vote_average"
        case title = "title"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIds = "genre_ids"
        case backDropPath = "backdrop_path"
        case adult = "adult"
        case overview = "overview"
        case releaseDate = "release_date"
    }
    
}
