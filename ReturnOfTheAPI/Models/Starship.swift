//
//  Starship.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 10/27/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation
import RealmSwift

final class Starship: RealmSwift.Object, Codable, ResourcePresentable, UnitProvider, Valuable {

    @objc dynamic var name: String = ""
    @objc dynamic var model: String = ""
    @objc dynamic var starshipClass: String = ""
    @objc dynamic var manufacturer: String = ""
    @objc dynamic var costInCredits: Double = 0
    var valueInDollars: Double = 0
    @objc dynamic var length: Double = 0
    @objc dynamic var crew: String = ""
    @objc dynamic var passengers: String = ""
    @objc dynamic var maxAtmosphereSpeed: String = ""
    @objc dynamic var hyperdriveRating: String = ""
    @objc dynamic var mglt: String = ""
    @objc dynamic var cargoCapacity: String = ""
    @objc dynamic var consumables: String = ""
    var providesUnitsIn: UnitType = .metric
    var unitLength: Length {
        return Length(meters: length)
    }

    override static func ignoredProperties() -> [String] {
        return ["valueInDollars"]
    }

    var basicInfo: [(label: String, value: Any)] {
        return [
            (label: "Name", value: name),
            (label: "Model", value: model),
            (label: "Class", value: starshipClass),
            (label: "Manufacturer", value: manufacturer),
            (label: "Cost (Credits)", value: costInCredits.description),
            (label: "Cost (USD)", value: valueInDollars.description),
            (label: "Length", value: unitLength.description(in: providesUnitsIn)),
            (label: "Crew", value: crew),
            (label: "Passengers", value: passengers),
            (label: "Max Atmosphering Speed", value: maxAtmosphereSpeed),
            (label: "Cargo Capacity", value: cargoCapacity),
            (label: "Consumables", value: consumables),
            (label: "Hyperdrive Rating", value: hyperdriveRating),
            (label: "Megalights Per Hour", value: mglt)
        ]
    }

    var filmsURL: [String] = []
    var pilotsURL: [String] = []
    @objc dynamic var url: String = ""
    let filmsList = List<String>()
    let pilotsList = List<String>()

    override static func primaryKey() -> String? {
        return "url"
    }

    var films: [Film] {
        guard let realm = try? Realm() else {
            return []
        }
        var filmsFound: [Film] = []
        for urlString in self.filmsList {
            if let film = realm.object(ofType: Film.self, forPrimaryKey: urlString) {
                filmsFound.append(film)
            }

        }
        let sortedFilms = filmsFound.sorted(by: {$0.episodeId < $1.episodeId})
        return sortedFilms
    }

    var pilots: [Character] {
        guard let realm = try? Realm() else {
            return []
        }
        var pilotsFound: [Character] = []
        for urlString in self.pilotsList {
            if let pilot = realm.object(ofType: Character.self, forPrimaryKey: urlString) {
                pilotsFound.append(pilot)
            }
        }
        return pilotsFound
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
        case filmsURL = "films"
        case pilotsURL = "pilots"
        case url
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        model = try container.decode(String.self, forKey: .model)
        starshipClass = try container.decode(String.self, forKey: .starshipClass)
        manufacturer = try container.decode(String.self, forKey: .manufacturer)
        let rawCredits = try container.decode(String.self, forKey: .costInCredits)
        if rawCredits == "unknown" {
            costInCredits = 0
        } else if let creditsAsDouble = Double(rawCredits) {
            costInCredits = creditsAsDouble
        }
        let lengthString = try container.decode(String.self, forKey: .length)
        if lengthString == "unknown" {
            length = 0
        } else if let numericLength = Double(lengthString) {
            length = numericLength
        } else {
            length = 0
        }
        crew = try container.decode(String.self, forKey: .crew)
        passengers = try container.decode(String.self, forKey: .passengers)
        maxAtmosphereSpeed = try container.decode(String.self, forKey: .maxAtmosphereSpeed)
        hyperdriveRating = try container.decode(String.self, forKey: .hyperdriveRating)
        mglt = try container.decode(String.self, forKey: .mglt)
        cargoCapacity = try container.decode(String.self, forKey: .cargoCapacity)
        consumables = try container.decode(String.self, forKey: .consumables)
        filmsURL = try container.decode([String].self, forKey: .filmsURL)
        pilotsURL = try container.decode([String].self, forKey: .pilotsURL)
        url = try container.decode(String.self, forKey: .url)

        pilotsList.append(objectsIn: pilotsURL)
        filmsList.append(objectsIn: filmsURL)
    }
}
