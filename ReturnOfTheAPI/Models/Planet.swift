//
//  Planet.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 10/27/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation
import RealmSwift

final class Planet: RealmSwift.Object, Codable {
    @objc dynamic var name: String = ""
    @objc dynamic var diameter: String = ""
    @objc dynamic var rotationPeriod: String = ""
    @objc dynamic var orbitalPeriod: String = ""
    @objc dynamic var gravity: String = ""
    @objc dynamic var population: String = ""
    @objc dynamic var climate: String = ""
    @objc dynamic var terrain: String = ""
    @objc dynamic var surfaceWater: String = ""
//    let residents: [Character]
//    let films: [Film]

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
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        diameter = try container.decode(String.self, forKey: .diameter)
        rotationPeriod = try container.decode(String.self, forKey: .rotationPeriod)
        orbitalPeriod = try container.decode(String.self, forKey: .orbitalPeriod)
        gravity = try container.decode(String.self, forKey: .gravity)
        population = try container.decode(String.self, forKey: .population)
        climate = try container.decode(String.self, forKey: .climate)
        terrain = try container.decode(String.self, forKey: .terrain)
        surfaceWater = try container.decode(String.self, forKey: .surfaceWater)
    }
}
