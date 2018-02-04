//
//  Character.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 10/27/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation
import RealmSwift

final class Character: RealmSwift.Object, Decodable, ResourcePresentable {
    @objc dynamic var birthYear: String = ""
    @objc dynamic var eyeColor: String = ""
    @objc dynamic var gender: String = ""
    @objc dynamic var hairColor: String = ""
    @objc dynamic var rawHeight: Double = 0
    @objc dynamic var homeworldURL: String = ""
    @objc dynamic var mass: Double = 0
    @objc dynamic var name: String = ""
    @objc dynamic var skinColor: String = ""
    var filmsURL: [String] = []
    var speciesURL: [String] = []
    var starshipsURL: [String] = []
    var vehiclesURL: [String] = []
    @objc dynamic var url: String = ""

    let starshipsList = List<String>()
    let vehiclesList = List<String>()
    let filmsList = List<String>()
    let speciesList = List<String>()
    private var unitFormatter: MeasurementFormatter {
        let numberFormat = NumberFormatter()
        numberFormat.maximumFractionDigits = 2
        numberFormat.decimalSeparator = "."
        switch self.providesUnitsIn {
        case .imperial:
            let formatter = MeasurementFormatter()
            formatter.numberFormatter = numberFormat
            formatter.locale = Locale(identifier: "en_US")
            return formatter
        case .metric:
            let formatter = MeasurementFormatter()
            formatter.numberFormatter = numberFormat
            formatter.locale = Locale(identifier: "en_CA")
            return formatter
        }
    }
    enum UnitProvider {
        case imperial
        case metric
    }
    var providesUnitsIn: UnitProvider = .metric
    var unitMass: Measurement<UnitMass> {
        return Measurement(value: mass, unit: UnitMass.kilograms)
    }

    var unitHeight: Measurement<UnitLength> {
        return Measurement(value: rawHeight, unit: UnitLength.centimeters)
    }

    var homeworld: Planet? {
        guard let realm = try? Realm() else {
            return nil
        }
        let world = realm.object(ofType: Planet.self, forPrimaryKey: self.homeworldURL)
        return world
    }

    var basicInfo: [(label: String, value: Any)] {
        unitFormatter.unitOptions = .naturalScale
        return [
            (label: "Name", value: name ),
            (label: "Birth Year", value: birthYear),
            (label: "Gender", value: gender),
            (label: "Homeworld", value: homeworld?.name ?? "Unknown"),
            (label: "Height", value: unitFormatter.string(from: unitHeight)),
            (label: "Weight", value: unitFormatter.string(from: unitMass)),
            (label: "Eye Color", value: eyeColor),
            (label: "Hair Color", value: hairColor),
            (label: "Skin Color", value: skinColor)
        ]
    }

    var starships: [Starship] {
        print("Accessed starships")
        guard let realm = try? Realm() else {
            return []
        }
        var shipsFound: [Starship] = []
        for urlString in self.starshipsList {
            print("Looking up ship for \(urlString)")
            if let ship = realm.object(ofType: Starship.self, forPrimaryKey: urlString) {
                shipsFound.append(ship)
                print("found ship resource!")
                print(ship)
            } else {
                print("Didn't find a ship resource")
            }
        }
        return shipsFound
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

    var vehicles: [Vehicle] {
        guard let realm = try? Realm() else {
            return []
        }
        var vehiclesFound: [Vehicle] = []
        for urlString in self.vehiclesList {
            if let vehicle = realm.object(ofType: Vehicle.self, forPrimaryKey: urlString) {
                vehiclesFound.append(vehicle)
            }
        }
        return vehiclesFound
    }

    override static func primaryKey() -> String? {
        return "url"
    }

    enum CodingKeys: String, CodingKey {
        case birthYear = "birth_year"
        case eyeColor = "eye_color"
        case filmsURL = "films"
        case gender
        case hairColor = "hair_color"
        case rawHeight = "height"
        case homeworld = "homeworld"
        case mass
        case name
        case skinColor = "skin_color"
        case speciesURL = "species"
        case starshipsURL = "starships"
        case vehiclesURL = "vehicles"
        case url
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        birthYear = try container.decode(String.self, forKey: .birthYear)
        eyeColor = try container.decode(String.self, forKey: .eyeColor)
        filmsURL = try container.decode([String].self, forKey: .filmsURL)
        gender = try container.decode(String.self, forKey: .gender)
        hairColor = try container.decode(String.self, forKey: .hairColor)
        let heightString = try container.decode(String.self, forKey: .rawHeight)

        if let numericHeight = Double(heightString) {
            rawHeight = numericHeight
        } else {
            rawHeight = 0
        }
        
        homeworldURL = try container.decode(String.self, forKey: .homeworld)
        starshipsURL = try container.decode([String].self, forKey: .starshipsURL)
        vehiclesURL = try container.decode([String].self, forKey: .vehiclesURL)
        let massString = try container.decode(String.self, forKey: .mass)
        if massString == "unknown" {
            mass = 0
        } else if let numericMass = Double(massString) {
            mass = numericMass
        } else {
            mass = 0
        }
        name = try container.decode(String.self, forKey: .name)
        skinColor = try container.decode(String.self, forKey: .skinColor)
        url = try container.decode(String.self, forKey: .url)

        starshipsList.append(objectsIn: starshipsURL)
        vehiclesList.append(objectsIn: vehiclesURL)
        filmsList.append(objectsIn: filmsURL)
    }
}
