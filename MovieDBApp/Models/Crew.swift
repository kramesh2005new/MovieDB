//
//  Crew.swift
//  MovieApp
//
//  Created by Ramesh on 05/03/19.
//  Copyright © 2019 Ramesh. All rights reserved.
//

import UIKit

class Crew: Codable {
    
    var credit_id: String?
    var gender: Int
    var id: Int
    var name: String?
    var job: String?
    var profile_path: String?
    var department: String?
    
    private enum CodingKeys: String, CodingKey {
        case credit_id
        case gender
        case id
        case name
        case job
        case profile_path
        case department
    }
    
}
