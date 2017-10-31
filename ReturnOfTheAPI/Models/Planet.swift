//
//  Planet.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 10/27/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation

class Planet: Codable {
    let name: String
    let diameter: Int
    let rotationPeriod: Int
    let orbitalPeriod: Int
    let gravity: Double
    let population: Int
    let climate: String
    let terrain: String
    let surfaceWater: Int
    let residents: [Character]
    let films: [Film]
    let lastModified: Date
    
    enum CodingKeys: String, CodingKey {
        case name
        case diameter
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case gravity
        case population
        case climate
        case terrain
        case surfaceWater = "surface_water"
        case residents
        case films
        case lastModified = "edited"
    }
}
