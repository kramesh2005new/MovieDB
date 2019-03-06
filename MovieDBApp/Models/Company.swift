//
//  Company.swift
//  MovieApp
//
//  Created by Ramesh on 27/02/19.
//  Copyright © 2019 Ramesh. All rights reserved.
//

import UIKit

class Company: Codable {

    var id: Int64
    var logoPath: String!
    var name: String
    var originCountry: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case logoPath = "logo_path"
        case name = "name"
        case originCountry = "origin_country"
    }
    
}
