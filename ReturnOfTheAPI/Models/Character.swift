//
//  Character.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 10/27/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation
import RealmSwift

final class Character: RealmSwift.Object, Decodable {
    @objc dynamic var birthYear: String = ""
    @objc dynamic var eyeColor: String = ""
    var filmsURL: [String] = []
    @objc dynamic var gender: String = ""
    @objc dynamic var hairColor: String = ""
    @objc dynamic var height: String = ""
    @objc dynamic var homeworldURL: String = ""
    @objc dynamic var mass: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var skinColor: String = ""
    var speciesURL: [String] = []
    var starshipsURL: [String] = []
    var vehiclesURL: [String] = []
    @objc dynamic var url: String = ""

    var homeworld: Planet? {
        guard let realm = try? Realm() else {
            return nil
        }
        let world = realm.object(ofType: Planet.self, forPrimaryKey: self.homeworldURL)
        return world
    }
    let species = List<Species>()
    let starships = List<Starship>()
    let vehicles = List<Vehicle>()

    override static func primaryKey() -> String? {
        return "url"
    }

    enum CodingKeys: String, CodingKey {
        case birthYear = "birth_year"
        case eyeColor = "eye_color"
        case filmsURL = "films"
        case gender
        case hairColor = "hair_color"
        case height
        case homeworld = "homeworld"
        case mass
        case name
        case skinColor = "skin_color"
        case speciesURL = "species"
        case starshipsURL = "starships"
        case vehiclesURL = "vehicles"
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        birthYear = try container.decode(String.self, forKey: .birthYear)
        eyeColor = try container.decode(String.self, forKey: .eyeColor)
        filmsURL = try container.decode([String].self, forKey: .filmsURL)
        gender = try container.decode(String.self, forKey: .gender)
        hairColor = try container.decode(String.self, forKey: .hairColor)
        height = try container.decode(String.self, forKey: .height)
        homeworldURL = try container.decode(String.self, forKey: .homeworld)
        mass = try container.decode(String.self, forKey: .mass)
        name = try container.decode(String.self, forKey: .name)
        skinColor = try container.decode(String.self, forKey: .skinColor)
    }
}
