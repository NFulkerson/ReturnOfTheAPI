//
//  SwapiFetchOperation.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 11/21/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation

class SwapiFetchOperation: Operation {
    fileprivate let downloader = JSONDownloader()
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
                self.error = SwapiError.networkInterruption
                return
            }
            print("Fetching data from \(endpoint.url)")
            data = try Data(contentsOf: endpoint.url)
            print("we have data~!")
        } catch let issue as Error {

            DispatchQueue.main.async {
                let swapiError = SwapiError.operationError(message: issue.localizedDescription)
                swapiError.presentError()
            }
        }

        print("Finished execution of fetch operation")
    }

    private func performRequest(with endpoint: Endpoint,
                                completion: @escaping (Data?, SwapiError?) -> Void) {
        let task = downloader.jsonDataTask(with: endpoint.request) { data, error in

            guard let data = data else {
                completion(nil, error)
                return
            }
            completion(data, nil)

        }
        task.resume()
    }

}
