//
//  UserInfo.swift
//  Navigation
//
//  Created by kubmakk on 08.08.2025.
//

import Foundation

struct Planet: Decodable {
    let name: String
    let orbitalPeriod: String
    let climate: String
    let gravity: String
    let population: String

    
    enum CodingKeys: String, CodingKey {
        case name
        case orbitalPeriod = "orbital_period"
        case climate
        case gravity
        case population
    }
}
