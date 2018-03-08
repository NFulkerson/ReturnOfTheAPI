//
//  Currency.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 2/27/18.
//  Copyright © 2018 Nathan. All rights reserved.
//

import Foundation
import RealmSwift

protocol Valuable: AnyObject {
    var costInCredits: Double { get set }
    var valueInDollars: Double { get set }
    func convertedToDollars(_ creditValue: Double, rate: Double)

}

extension Valuable {
    func convertedToDollars(_ creditValue: Double, rate: Double) {
        self.valueInDollars = creditValue * rate
    }
}

