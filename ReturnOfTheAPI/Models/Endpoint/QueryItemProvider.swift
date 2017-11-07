//
//  QueryItemProvider.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 11/3/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation
// We may use this for paginating through JSON data
protocol QueryItemProvider {
    var queryItem: URLQueryItem { get }
}
