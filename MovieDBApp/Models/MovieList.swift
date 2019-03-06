//
//  MovieList.swift
//  MovieApp
//
//  Created by Ramesh on 27/02/19.
//  Copyright © 2019 Ramesh. All rights reserved.
//

import UIKit

class MovieList: Codable {
    
    var results: [Movie]
    var page: Int
    var total_results: Int
    var total_pages: Int
    
    private enum CodingKeys: String, CodingKey {
        case results
        case page
        case total_results
        case total_pages
    }

}
