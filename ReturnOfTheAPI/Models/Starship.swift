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
    let costInCredits: String
    let length: String
    let crew: String
    let passengers: String
    let maxAtmosphereSpeed: String
    let hyperdriveRating: String
    let mglt: String
    let cargoCapacity: String
    let consumables: String
//    let films: [Film]
//    let pilots: [Character]
    let lastModified: String

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
//        case films
//        case pilots
        case lastModified = "edited"
    }
}
