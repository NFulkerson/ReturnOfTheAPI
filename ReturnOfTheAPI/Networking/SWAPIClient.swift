//
//  SWAPIClient.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 11/2/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation

class SwapiClient {
    let downloader = JSONDownloader()

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

    func retrievePaginatedCharacters(
        completion: @escaping ([Character]?, SwapiError?) -> Void) {
        let endpoint = Swapi.list(resource: .character)
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
