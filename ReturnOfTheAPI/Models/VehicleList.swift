//
//  VehicleList.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 11/7/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation

struct VehicleList: Decodable {
    let count: Int
    let paginationURL: String?
    let results: [Vehicle]

    enum CodingKeys: String, CodingKey {
        case count
        case paginationURL = "next"
        case results
    }
}
