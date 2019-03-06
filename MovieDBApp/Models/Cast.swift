//
//  Cast.swift
//  MovieApp
//
//  Created by Ramesh on 05/03/19.
//  Copyright © 2019 Ramesh. All rights reserved.
//

import UIKit

class Cast: Codable {
    
    var cast_id: Int
    var character: String?
    var credit_id: String?
    var gender: Int
    var id: Int
    var name: String?
    var order: Int
    var profile_path: String?
    
    private enum CodingKeys: String, CodingKey {
        case cast_id
        case character
        case credit_id
        case gender
        case id
        case name
        case order
        case profile_path
        
    }

}
