//
//  Country.swift
//  MovieApp
//
//  Created by Ramesh on 27/02/19.
//  Copyright © 2019 Ramesh. All rights reserved.
//

import UIKit

class Country: Codable {
    
    var id: String
    var name: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "iso_3166_1"
        case name
    }

}
