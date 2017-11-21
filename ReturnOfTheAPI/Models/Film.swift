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
    @objc dynamic var episodeId: String = ""
    @objc dynamic var openingCrawl: String = ""
    @objc dynamic var director: String = ""
    @objc dynamic var producer: String = ""
    @objc dynamic var releaseDate: String = ""
    //let characters: [Character]
    //let planets: [Planet]
    //let starships: [Starship]
    //let vehicles: [Vehicle]
    //let species: [Species]

    enum CodingKeys: String, CodingKey {
        case title
        case episodeId = "episode_id"
        case openingCrawl = "opening_crawl"
        case director
        case producer
        case releaseDate = "release_date"
        //case characters
        //case planets
        //case starships
        //case vehicles
        //case species
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        episodeId = try container.decode(String.self, forKey: .episodeId)
        openingCrawl = try container.decode(String.self, forKey: .openingCrawl)
        director = try container.decode(String.self, forKey: .director)
        producer = try container.decode(String.self, forKey: .producer)
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
    }
}
