//
//  PaginatedResult.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 11/9/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation

protocol PaginatedResult: QueryItemProvider {
    var resultPage: String { get }
}

extension PaginatedResult {
    var queryItem: URLQueryItem {
        return URLQueryItem(name: "page", value: resultPage)
    }
}
