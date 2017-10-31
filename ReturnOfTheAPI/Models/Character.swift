//
//  Character.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 10/27/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation

class Character: Codable {
    let birthYear: String
    let eyeColor: String
    let films: [Film]
    let gender: String
    let hairColor: String
    let height: Int
    let homeworld: Planet
    let mass: Int
    let name: String
    let skinColor: String
    let lastModified: Date
    let species: [Species]
    let starships: [Starship]
    let vehicles: [Vehicle]
    
    enum CodingKeys: String, CodingKey {
        case birthYear = "birth_year"
        case eyeColor = "eye_color"
        case films
        case gender
        case hairColor = "hair_color"
        case height
        case homeworld
        case mass
        case name
        case skinColor = "skin_color"
        case lastModified = "edited"
        case species
        case starships
        case vehicles
    }
}

