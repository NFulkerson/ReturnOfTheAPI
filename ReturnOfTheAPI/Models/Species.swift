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
    @objc dynamic var language: String = ""
    @objc dynamic var url: String = ""

    enum CodingKeys: String, CodingKey {
        case name
        case classification
        case designation
        case averageHeight = "average_height"
        case averageLifespan = "average_lifespan"
        case language
        case url
    }

    override static func primaryKey() -> String? {
        return "url"
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        classification = try container.decode(String.self, forKey: .classification)
        designation = try container.decode(String.self, forKey: .designation)
        averageHeight = try container.decode(String.self, forKey: .averageHeight)
        averageLifespan = try container.decode(String.self, forKey: .averageLifespan)
        language = try container.decode(String.self, forKey: .language)
        url = try container.decode(String.self, forKey: .url)
    }
}
