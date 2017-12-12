//
//  VehicleList.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 11/7/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation
import RealmSwift

struct ResourceList: Decodable {
    var count: Int
    var paginationURL: String?
    var results: [AnyObject]
    var resourceType: SwapiResource?

    enum CodingKeys: String, CodingKey {
        case count
        case paginationURL = "next"
        case results
    }
    
    init(from resource: SwapiResource, data: Data) throws {
        resourceType = resource
        self = try JSONDecoder().decode(ResourceList.self, from: data)
    }

    init(from decoder: Decoder) throws {
        guard let resource = resourceType else {
            throw SwapiError.decodingFailed(message: "Improper resource type")
        }
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        paginationURL = try container.decode(String.self, forKey: .paginationURL)
        switch resource {
        case .character:
            results = try container.decode([Character].self, forKey: .results)
        case .film:
            results = try container.decode([Film].self, forKey: .results)
        case .planet:
            results = try container.decode([Planet].self, forKey: .results)
        case .species:
            results = try container.decode([Species].self, forKey: .results)
        case .starship:
            results = try container.decode([Starship].self, forKey: .results)
        case .vehicle:
            results = try container.decode([Vehicle].self, forKey: .results)
        }
    }
}

