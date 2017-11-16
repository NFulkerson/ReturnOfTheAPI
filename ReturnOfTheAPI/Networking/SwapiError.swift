//
//  SwapiError.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 11/1/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation

enum SwapiError: Error {
    case requestFailed
    case responseUnsuccessful
    case networkInterruption
    case invalidData
    case decodingFailed(message: String)
}
