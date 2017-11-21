//
//  Character.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 10/27/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation
import RealmSwift

final class Character: RealmSwift.Object, Codable {
    @objc dynamic var birthYear: String = ""
    @objc dynamic var eyeColor: String = ""
//    let films: [Film]
    @objc dynamic var gender: String = ""
    @objc dynamic var hairColor: String = ""
    @objc dynamic var height: String = ""
//    let homeworld: Planet
    @objc dynamic var mass: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var skinColor: String = ""
//    let species: [Species]
//    let starships: [Starship]
//    let vehicles: [Vehicle]

    override static func primaryKey() -> String? {
        return "name"
    }

    enum CodingKeys: String, CodingKey {
        case birthYear = "birth_year"
        case eyeColor = "eye_color"
        //        case films
        case gender
        case hairColor = "hair_color"
        case height
        //        case homeworld
        case mass
        case name
        case skinColor = "skin_color"
        //        case species
        //        case starships
        //        case vehicles
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        birthYear = try container.decode(String.self, forKey: .birthYear)
        eyeColor = try container.decode(String.self, forKey: .eyeColor)
        gender = try container.decode(String.self, forKey: .gender)
        hairColor = try container.decode(String.self, forKey: .hairColor)
        height = try container.decode(String.self, forKey: .height)
        mass = try container.decode(String.self, forKey: .mass)
        name = try container.decode(String.self, forKey: .name)
        skinColor = try container.decode(String.self, forKey: .skinColor)
    }
}
