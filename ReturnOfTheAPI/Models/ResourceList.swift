//
//  VehicleList.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 11/7/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation
import RealmSwift
// Sweet almighty, the amount of time it took me to arrive at this...
struct ResourceList<T: Decodable>: Decodable {
    var count: Int
    var paginationURL: String?
    var results: [T]

    enum CodingKeys: String, CodingKey {
        case count
        case paginationURL = "next"
        case results
    }
}
