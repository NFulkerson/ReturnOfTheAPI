//
//  JSONDownloader.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 11/1/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation

class JSONDownloader {
    let session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

    typealias JSONTaskCompletionHandler = (Data?, SwapiError?) -> Void

    func jsonDataTask(with request: URLRequest,
                      completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                print(error as Any)
                return
            }

            if httpResponse.statusCode == 200 {
                if let data = data {
                    completion(data, nil)
                } else {
                    completion(nil, .invalidData(message: "Data is missing or invalid."))
                    print(error as Any)
                }
            } else {
                print("""
                    ------ERROR------
                    request:\(String(describing: request.url))\n
                    response:\(httpResponse.statusCode)
                    """)
                completion(nil, .responseUnsuccessful)
                print(error as Any)
            }
        }
        return task
    }
}
