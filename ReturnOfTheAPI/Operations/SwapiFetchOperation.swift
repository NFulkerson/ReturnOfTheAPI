//
//  SwapiFetchOperation.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 11/21/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation

class SwapiFetchOperation: Operation {
    let endpoint: Endpoint
    private(set) var data: Data?
    var error: SwapiError?

    init(with endpoint: Endpoint) {
        self.endpoint = endpoint
    }

    override func main() {
        do {
            if self.isCancelled {
                print("Canceled fetch operation.")
                return
            }
            print("Fetching data from \(endpoint.url)")
            data = try Data(contentsOf: endpoint.url)
            print("we have data~!")
        } catch {
            self.error = SwapiError.invalidData(message: "Data is missing or invalid.")
        }

        print("Finished execution of fetch operation")
    }

}
