//
//  Genres.swift
//  MovieApp
//
//  Created by Ramesh on 27/02/19.
//  Copyright © 2019 Ramesh. All rights reserved.
//

import UIKit

class Genres : Codable {
    
    var id: Int
    var name: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
    }

}
