//
//  Film.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 10/27/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation
import RealmSwift

final class Film: RealmSwift.Object, Codable {
    @objc dynamic var title: String = ""
    @objc dynamic var episodeId: Int = 0
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var url: String = ""

    enum CodingKeys: String, CodingKey {
        case title
        case episodeId = "episode_id"
        case releaseDate = "release_date"
        case url
    }

    override static func primaryKey() -> String? {
        return "url"
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        episodeId = try container.decode(Int.self, forKey: .episodeId)
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
        url = try container.decode(String.self, forKey: .url)
    }
}
