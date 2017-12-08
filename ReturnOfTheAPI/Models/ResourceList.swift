//
//  VehicleList.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 11/7/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation

struct ResourceList: Decodable {
    let count: Int
    let paginationURL: String?
    let results: Data

    enum CodingKeys: String, CodingKey {
        case count
        case paginationURL = "next"
        case results
    }
}
