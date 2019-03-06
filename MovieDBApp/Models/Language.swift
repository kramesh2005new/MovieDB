//
//  Language.swift
//  MovieApp
//
//  Created by Ramesh on 27/02/19.
//  Copyright © 2019 Ramesh. All rights reserved.
//

import UIKit

class Language: Codable {
    
    var id: String
    var name: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "iso_639_1"
        case name
    }

}
