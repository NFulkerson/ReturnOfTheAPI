//
//  SwapiError.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 11/1/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import UIKit

enum SwapiError: Error {
    case requestFailed
    case responseUnsuccessful
    case networkInterruption
    case invalidData(message: String)
    case decodingFailed(message: String)
    case resourceNotFound(message: String)
    case operationError(message: String)

    func presentError() {
        var title: String
        var message: String
        switch self {
        case .requestFailed:
            title = "Request Failed"
            message = "Could not successfully complete request."
        case .responseUnsuccessful:
            title = "Response Unsuccessful"
            message = "Did not receive response from server."
        case .networkInterruption:
            title = "Network Error"
            message = "The network connection has been interrupted. Please check the status of your network and try again."
        case .invalidData(let dataError):
            message = dataError
            title = "Invalid Data"
        case .decodingFailed(let decodingError):
            title = "Decoding Failed"
            message = decodingError
        case .resourceNotFound(let resourceError):
            title = "Resource Not Found"
            message = resourceError
        case .operationError(let errorMessage):
            title = "Error"
            message = errorMessage
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
