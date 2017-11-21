//
//  SWAPIClient.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 11/2/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation
import RealmSwift

class SwapiClient {
    fileprivate let downloader = JSONDownloader()
    fileprivate lazy var operationQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "com.nfulkerson.swapiclient"
        return queue
    }()

    // MARK: - Network Requests

    func retrieveCharacter(with resourceId: Int,
                           completion: @escaping (Character?, SwapiError?) -> Void) {

        let endpoint = Swapi.request(resource: .character, id: resourceId)

        performRequest(with: endpoint) { data, error in

            guard let data = data else {
                completion(nil, error)
                return
            }

            let decoder = JSONDecoder()

            do {
                let character = try decoder.decode(Character.self, from: data)
                completion(character, nil)
            } catch {
                completion(nil, .decodingFailed(message: String(describing: error)))
            }
        }
    }

    func getPaginatedData(for resource: SwapiResource,
                          completion: @escaping ([Character]?, SwapiError?) -> Void) {

        let endpoint = Swapi.list(resource: resource)

        performRequest(with: endpoint) { data, error in
            guard let data = data else {
                completion(nil, error)
                return
            }

            let decoder = JSONDecoder()
            do {
                let characterResults = try decoder.decode(CharacterList.self, from: data)
                let characters = characterResults.results
                completion(characters, nil)
            } catch {
                completion(nil, .decodingFailed(message: String(describing: error)))
            }
        }
    }

    func getPaginatedData(string urlString: String,
                          completion: @escaping ([Character]?, SwapiError?) -> Void) {
        print("Url String: \(urlString)")

        let endpoint = Swapi.pagedUrl(urlString: urlString)
        performRequest(with: endpoint) { data, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            let decoder = JSONDecoder()
            do {
                let results = try decoder.decode(CharacterList.self, from: data)
                let characters = results.results
                completion(characters, nil)
            } catch {
                completion(nil, .decodingFailed(message: String(describing: error)))
            }
        }
    }

    func saveResultList(from urlString: String) {
        let endpoint = Swapi.pagedUrl(urlString: urlString)
        performRequest(with: endpoint) { [weak self] data, error in
            guard let data = data else {
                print(error)
                return
            }
            self?.operationQueue.qualityOfService = .userInteractive
            let decodeAndSaveOp = SwapiDecodeOperation(with: data, for: SwapiResource.character)
            self?.operationQueue.addOperation(decodeAndSaveOp)
            print("Inside Closure: \(self?.operationQueue.isSuspended)")
            print("Inside closure: \(self?.operationQueue.operationCount)")

        }
        print(operationQueue.isSuspended)
        print(operationQueue.operationCount)
    }

    private func performRequest(with endpoint: Endpoint,
                                completion: @escaping (Data?, SwapiError?) -> Void) {
        let task = downloader.jsonDataTask(with: endpoint.request) { data, error in
            DispatchQueue.main.async {
                guard let data = data else {
                    completion(nil, error)
                    return
                }

                completion(data, nil)
            }
        }
        task.resume()
    }

}
