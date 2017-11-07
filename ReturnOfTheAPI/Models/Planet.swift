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
    let diameter: String
    let rotationPeriod: String
    let orbitalPeriod: String
    let gravity: String
    let population: String
    let climate: String
    let terrain: String
    let surfaceWater: String
//    let residents: [Character]
//    let films: [Film]
    let lastModified: String

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
//        case residents
//        case films
        case lastModified = "edited"
    }
}
