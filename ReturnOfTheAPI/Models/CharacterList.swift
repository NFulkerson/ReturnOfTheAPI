//
//  CharacterList.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 11/3/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation

struct CharacterList: Decodable {
    var count: Int
    var paginationURL: String?
    var results: [Character]

    enum CodingKeys: String, CodingKey {
        case count
        case paginationURL = "next"
        case results
    }
}
