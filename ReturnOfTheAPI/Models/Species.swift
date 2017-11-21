//
//  Species.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 10/27/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation
import RealmSwift

final class Species: RealmSwift.Object, Codable {
    @objc dynamic var name: String = ""
    @objc dynamic var classification: String = ""
    @objc dynamic var designation: String = ""
    @objc dynamic var averageHeight: String = ""
    @objc dynamic var averageLifespan: String = ""
    @objc dynamic var eyeColors: String = ""
    @objc dynamic var hairColors: String = ""
    @objc dynamic var skinColors: String = ""
    @objc dynamic var language: String = ""
//    let homeworld: Planet
//    let people: [Character]
//    let films: [Film]

    enum CodingKeys: String, CodingKey {
        case name
        case classification
        case designation
        case averageHeight = "average_height"
        case averageLifespan = "average_lifespan"
        case eyeColors = "eye_colors"
        case hairColors = "hair_colors"
        case skinColors = "skin_colors"
        case language
//        case homeworld
//        case people
//        case films
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        classification = try container.decode(String.self, forKey: .classification)
        designation = try container.decode(String.self, forKey: .designation)
        averageHeight = try container.decode(String.self, forKey: .averageHeight)
        averageLifespan = try container.decode(String.self, forKey: .averageLifespan)
        eyeColors = try container.decode(String.self, forKey: .eyeColors)
        hairColors = try container.decode(String.self, forKey: .hairColors)
        skinColors = try container.decode(String.self, forKey: .skinColors)
        language = try container.decode(String.self, forKey: .language)
    }
}
