//
//  Vehicle.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 10/27/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation
import RealmSwift

final class Vehicle: RealmSwift.Object, Codable, ResourcePresentable {
    @objc dynamic var name: String = ""
    @objc dynamic var model: String = ""
    @objc dynamic var vehicleClass: String = ""
    @objc dynamic var manufacturer: String = ""
    @objc dynamic var length: Double = 0
    @objc dynamic var costInCredits: String = ""
    @objc dynamic var crew: String = ""
    @objc dynamic var passengers: String = ""
    @objc dynamic var maxAtmosphereSpeed: String = ""
    @objc dynamic var cargoCapacity: String = ""
    @objc dynamic var consumables: String = ""
    var filmsURL: [String] = []
    var pilotsURL: [String] = []
    @objc dynamic var url: String = ""

    var unitLength: String {
        let unitLength = Measurement(value: length, unit: UnitLength.meters)
        let measureFormat = MeasurementFormatter()
        measureFormat.unitOptions = .providedUnit
        return measureFormat.string(from: unitLength)
    }

    let filmsList = List<String>()
    let pilotsList = List<String>()

    var basicInfo: [(label: String, value: Any)] {
        return [
            (label: "Name", value: name),
            (label: "Model", value: model),
            (label: "Class", value: vehicleClass),
            (label: "Manufacturer", value: manufacturer),
            (label: "Length", value: unitLength),
            (label: "Cost", value: costInCredits),
            (label: "Crew", value: crew),
            (label: "Passengers", value: passengers),
            (label: "Max Atmosphering Speed", value: maxAtmosphereSpeed),
            (label: "Cargo Capacity", value: cargoCapacity),
            (label: "Consumables", value: consumables)
        ]
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

    override static func primaryKey() -> String? {
        return "url"
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
        case filmsURL = "films"
        case pilotsURL = "pilots"
        case url
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        model = try container.decode(String.self, forKey: .model)
        vehicleClass = try container.decode(String.self, forKey: .vehicleClass)
        manufacturer = try container.decode(String.self, forKey: .manufacturer)
        let lengthString = try container.decode(String.self, forKey: .length)
        if lengthString == "unknown" {
            length = 0
        } else if let numericLength = Double(lengthString) {
            length = numericLength
        } else {
            length = 0
        }
        costInCredits = try container.decode(String.self, forKey: .costInCredits)
        crew = try container.decode(String.self, forKey: .crew)
        passengers = try container.decode(String.self, forKey: .passengers)
        maxAtmosphereSpeed = try container.decode(String.self, forKey: .maxAtmosphereSpeed)
        cargoCapacity = try container.decode(String.self, forKey: .cargoCapacity)
        consumables = try container.decode(String.self, forKey: .consumables)
        filmsURL = try container.decode([String].self, forKey: .filmsURL)
        pilotsURL = try container.decode([String].self, forKey: .pilotsURL)
        url = try container.decode(String.self, forKey: .url)

        pilotsList.append(objectsIn: pilotsURL)
        filmsList.append(objectsIn: filmsURL)
    }
}
