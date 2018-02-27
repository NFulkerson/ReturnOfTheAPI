//
//  Currency.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 2/27/18.
//  Copyright © 2018 Nathan. All rights reserved.
//

import Foundation

enum Currency {
    case usd(Float)
    case galacticCredits(Float)

    func convert(with rate: Float) -> Currency {
        switch self {
        case .usd(let amount):
            let result = amount * rate
            return Currency.galacticCredits(result)
        case .galacticCredits(let amount):
            let result = amount / rate
            return Currency.usd(result)
        }
    }
}
