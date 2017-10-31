//
//  Starship.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 10/27/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation

class Starship: Codable {
    let name: String
    let model: String
    let starshipClass: String
    let manufacturer: String
    let costInCredits: Int
    let length: Int
    let crew: Int
    let passengers: Int
    let maxAtmosphereSpeed: Int
    let hyperdriveRating: Double
    let mglt: String
    let cargoCapacity: Int
    let consumables: String
    let films: [Film]
    let pilots: [Character]
    let lastModified: Date
    
    enum CodingKeys: String, CodingKey {
        case name
        case model
        case starshipClass = "starship_class"
        case manufacturer
        case costInCredits = "cost_in_credits"
        case length
        case crew
        case passengers
        case maxAtmosphereSpeed = "max_atmosphering_speed"
        case hyperdriveRating = "hyperdrive_rating"
        case mglt = "MGLT"
        case cargoCapacity = "cargo_capacity"
        case consumables = "consumables"
        case films
        case pilots
        case lastModified = "edited"
    }
}
