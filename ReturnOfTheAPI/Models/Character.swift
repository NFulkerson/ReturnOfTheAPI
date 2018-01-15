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
    @objc dynamic var gender: String = ""
    @objc dynamic var hairColor: String = ""
    @objc dynamic var height: String = ""
    @objc dynamic var homeworldURL: String = ""
    @objc dynamic var mass: String = ""
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

    var homeworld: Planet? {
        guard let realm = try? Realm() else {
            return nil
        }
        let world = realm.object(ofType: Planet.self, forPrimaryKey: self.homeworldURL)
        return world
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
        case height
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
        height = try container.decode(String.self, forKey: .height)
        homeworldURL = try container.decode(String.self, forKey: .homeworld)
        starshipsURL = try container.decode([String].self, forKey: .starshipsURL)
        vehiclesURL = try container.decode([String].self, forKey: .vehiclesURL)
        mass = try container.decode(String.self, forKey: .mass)
        name = try container.decode(String.self, forKey: .name)
        skinColor = try container.decode(String.self, forKey: .skinColor)
        url = try container.decode(String.self, forKey: .url)

        starshipsList.append(objectsIn: starshipsURL)
        vehiclesList.append(objectsIn: vehiclesURL)
        filmsList.append(objectsIn: filmsURL)
    }
}
