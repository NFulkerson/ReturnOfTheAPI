//
//  CharacterList.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 11/3/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation

class CharacterList: Decodable {
    let count: Int
    let paginationURL: String
    let results: [Character]

    enum CodingKeys: String, CodingKey {
        case count
        case paginationURL = "next"
        case results
    }
}
