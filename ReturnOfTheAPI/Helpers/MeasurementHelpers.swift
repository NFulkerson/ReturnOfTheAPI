//
//  MeasurementHelpers.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 2/1/18.
//  Copyright © 2018 Nathan. All rights reserved.
//

import Foundation

protocol UnitProvider {
    var providesUnitsIn: UnitType { get set }
}

enum UnitType {
    case imperial
    case metric
}

struct Height {
    let formatter = MeasurementFormatter()
    private var internalHeight: Double?
    var height: Double {
        get {
            return internalHeight!
        }
        set {
            internalHeight = newValue
            formatter.locale = Locale(identifier: "en_CA")
            formatter.numberFormatter.maximumFractionDigits = 2
            formatter.numberFormatter.decimalSeparator = "."

            if newValue >= 1 && newValue <= 100 {
                formatter.unitOptions = .providedUnit
            } else {
                formatter.unitOptions = .naturalScale
            }
        }
    }

    init(cmHeight: Double) {
        height = cmHeight
    }

    func description(in units: UnitType) -> String {
        switch units {
        case .imperial:
            return self.inFeetAndInches()
        case .metric:
            return self.inCm()
        }
    }

    func inCm() -> String {
        if height <= 0 {
            return "Unknown"
        } else {
            let measure = Measurement(value: height, unit: UnitLength.centimeters)
            return formatter.string(from: measure)
        }
    }

    func inFeetAndInches() -> String {
        if height <= 0 {
            return "Unknown"
        } else {
            formatter.locale = Locale(identifier: "en_US")
            formatter.unitOptions = .providedUnit
            formatter.numberFormatter.roundingMode = .halfUp
            formatter.numberFormatter.maximumFractionDigits = 0
            let measure = Measurement(value: height, unit: UnitLength.centimeters).converted(to: .inches)
            let measureTuple = getWholeFeetAndInches(from: measure)

            let ft = formatter.string(from: measureTuple.feet)
            let inches = formatter.string(from: measureTuple.inches)

            return "\(ft) \(inches)"
        }
    }

    private func getWholeFeetInInches(from inches: Double) -> Double {
        return floor(inches / 12) * 12
    }

    private func getWholeFeetAndInches(from measurement: Measurement<UnitLength>)
        -> (feet: Measurement<UnitLength>, inches: Measurement<UnitLength> ) {
            let totalInches = measurement.converted(to: .inches)
            let feetInInches = getWholeFeetInInches(from: totalInches.value)
            let inches = totalInches.value - feetInInches
            let wholeInches = Measurement(value: inches, unit: UnitLength.inches)
            let wholeFeet = Measurement(value: feetInInches, unit: UnitLength.inches).converted(to: .feet)
            return (feet: wholeFeet, inches: wholeInches)
    }
}

struct Weight {
    let formatter = MeasurementFormatter()
    private var internalWeight: Double?

    var weight: Double {
        get {
            return internalWeight!
        }
        set {
            internalWeight = newValue
            formatter.locale = Locale(identifier: "en_CA")
            formatter.numberFormatter.maximumFractionDigits = 2
            formatter.numberFormatter.decimalSeparator = "."
        }
    }

    init(kilograms: Double) {
        weight = kilograms
    }

    func description(in units: UnitType) -> String {
        switch units {
        case .metric:
            return self.inKilograms()
        case .imperial:
            return self.inPounds()
        }
    }

    func inKilograms() -> String {
        if weight <= 0 {
            return "Unknown"
        } else {
            let measure = Measurement(value: weight, unit: UnitMass.kilograms)
            return formatter.string(from: measure)
        }
    }

    func inPounds() -> String {
        if weight <= 0 {
            return "Unknown"
        } else {
            let measure = Measurement(value: weight, unit: UnitMass.kilograms).converted(to: .pounds)
            return formatter.string(from: measure)
        }
    }
}

struct Length {
    let formatter = MeasurementFormatter()
    private var internalLength: Double?

    var length: Double {
        get {
            return internalLength!
        }
        set {
            internalLength = newValue
        }
    }

    init(meters: Double) {
        length = meters
        formatter.locale = Locale(identifier: "en_CA")
        formatter.numberFormatter.maximumFractionDigits = 2
        formatter.numberFormatter.decimalSeparator = "."
        formatter.unitOptions = .providedUnit
    }

    func description(in units: UnitType) -> String {
        switch units {
        case .metric:
            return self.inMeters()
        case .imperial:
            return self.inFeet()
        }
    }

    func inMeters() -> String {
        if length <= 0 {
            return "Unknown"
        } else {
            let measure = Measurement(value: length, unit: UnitLength.meters)
            return formatter.string(from: measure)
        }
    }

    func inFeet() -> String {
        if length <= 0 {
            return "Unknown"
        } else {
            let measure = Measurement(value: length, unit: UnitLength.meters).converted(to: .feet)
            return formatter.string(from: measure)
        }
    }
}
