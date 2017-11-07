//
//  Film.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 10/27/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation

class Film: Codable {
    let title: String
    let episodeId: String
    let openingCrawl: String
    let director: String
    let producer: String
    let releaseDate: String
    //let characters: [Character]
    //let planets: [Planet]
    //let starships: [Starship]
    //let vehicles: [Vehicle]
    //let species: [Species]
    let lastModified: String

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
        case lastModified = "edited"
    }
}
