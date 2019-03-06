//
//  MovieVideo.swift
//  MovieApp
//
//  Created by Ramesh on 05/03/19.
//  Copyright © 2019 Ramesh. All rights reserved.
//

import UIKit

class MovieVideoCollection: Codable
{
    var id: Int
    var results: [MovieVideo]
    
    private enum CodingKeys: String, CodingKey {
        case id
        case results
    }
}

class MovieVideo: Codable {
    
    var id: String 
    var language: String
    var country: String
    var key: String
    var name: String
    var site: String
    var size: Int
    var type: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case language = "iso_639_1"
        case country = "iso_3166_1"
        case key
        case name
        case site
        case size
        case type
        
    }

}
