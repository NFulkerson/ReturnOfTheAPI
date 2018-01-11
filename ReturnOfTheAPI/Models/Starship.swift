//
//  Starship.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 10/27/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation
import RealmSwift

final class Starship: RealmSwift.Object, Codable {
    @objc dynamic var name: String = ""
    @objc dynamic var model: String = ""
    @objc dynamic var starshipClass: String = ""
    @objc dynamic var manufacturer: String = ""
    @objc dynamic var costInCredits: String = ""
    @objc dynamic var length: String = ""
    @objc dynamic var crew: String = ""
    @objc dynamic var passengers: String = ""
    @objc dynamic var maxAtmosphereSpeed: String = ""
    @objc dynamic var hyperdriveRating: String = ""
    @objc dynamic var mglt: String = ""
    @objc dynamic var cargoCapacity: String = ""
    @objc dynamic var consumables: String = ""
//    let films: [Film]
//    let pilots: [Character]
    @objc dynamic var url: String = ""

    override static func primaryKey() -> String? {
        return "url"
    }

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
        case url
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        model = try container.decode(String.self, forKey: .model)
        starshipClass = try container.decode(String.self, forKey: .starshipClass)
        manufacturer = try container.decode(String.self, forKey: .manufacturer)
        costInCredits = try container.decode(String.self, forKey: .costInCredits)
        length = try container.decode(String.self, forKey: .length)
        crew = try container.decode(String.self, forKey: .crew)
        passengers = try container.decode(String.self, forKey: .passengers)
        maxAtmosphereSpeed = try container.decode(String.self, forKey: .maxAtmosphereSpeed)
        hyperdriveRating = try container.decode(String.self, forKey: .hyperdriveRating)
        mglt = try container.decode(String.self, forKey: .mglt)
        cargoCapacity = try container.decode(String.self, forKey: .cargoCapacity)
        consumables = try container.decode(String.self, forKey: .consumables)
        url = try container.decode(String.self, forKey: .url)
    }
}
