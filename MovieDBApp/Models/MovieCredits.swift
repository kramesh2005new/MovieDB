//
//  MovieCredits.swift
//  MovieApp
//
//  Created by Ramesh on 05/03/19.
//  Copyright © 2019 Ramesh. All rights reserved.
//

import UIKit

class MovieCredits: Codable {
    
    var id: Int
    var cast: [Cast]
    var crew: [Crew]
    
    private enum CodingKeys: String, CodingKey {
        case id
        case cast
        case crew
    }

}
