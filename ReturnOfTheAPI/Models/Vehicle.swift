//
//  Vehicle.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 10/27/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation

class Vehicle: Codable {
    let name: String
    let model: String
    let `class`: String
    let manufacturer: String
    let length: String
    let costInCredits: String
    let crew: String
    let passengers: String
    let maxAtmosphereSpeed: String
    let cargoCapacity: String
    let consumables: String
//    let films: [Film]
//    let pilots: [Character]
    let lastModified: String

    enum CodingKeys: String, CodingKey {
        case name
        case model
        case `class` = "vehicle_class"
        case manufacturer
        case length
        case costInCredits = "cost_in_credits"
        case crew
        case passengers
        case maxAtmosphereSpeed = "max_atmosphering_speed"
        case cargoCapacity = "cargo_capacity"
        case consumables
//        case films
//        case pilots
        case lastModified = "edited"
    }
}
