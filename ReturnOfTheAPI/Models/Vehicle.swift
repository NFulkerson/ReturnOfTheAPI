//
//  Vehicle.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 10/27/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation
import RealmSwift

final class Vehicle: RealmSwift.Object, Codable {
    @objc dynamic var name: String = ""
    @objc dynamic var model: String = ""
    @objc dynamic var vehicleClass: String = ""
    @objc dynamic var manufacturer: String = ""
    @objc dynamic var length: String = ""
    @objc dynamic var costInCredits: String = ""
    @objc dynamic var crew: String = ""
    @objc dynamic var passengers: String = ""
    @objc dynamic var maxAtmosphereSpeed: String = ""
    @objc dynamic var cargoCapacity: String = ""
    @objc dynamic var consumables: String = ""
//    let films: [Film]
//    let pilots: [Character]

    override static func primaryKey() -> String? {
        return "name"
    }

    enum CodingKeys: String, CodingKey {
        case name
        case model
        case vehicleClass = "vehicle_class"
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
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        model = try container.decode(String.self, forKey: .model)
        vehicleClass = try container.decode(String.self, forKey: .vehicleClass)
        manufacturer = try container.decode(String.self, forKey: .manufacturer)
        length = try container.decode(String.self, forKey: .length)
        costInCredits = try container.decode(String.self, forKey: .costInCredits)
        crew = try container.decode(String.self, forKey: .crew)
        passengers = try container.decode(String.self, forKey: .passengers)
        maxAtmosphereSpeed = try container.decode(String.self, forKey: .maxAtmosphereSpeed)
        cargoCapacity = try container.decode(String.self, forKey: .cargoCapacity)
        consumables = try container.decode(String.self, forKey: .consumables)
    }
}
