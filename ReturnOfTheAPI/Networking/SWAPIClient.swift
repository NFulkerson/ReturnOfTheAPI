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

    func retrieveResources(for type: SwapiResource) {
        let endpoint = Swapi.list(resource: type)
        retrieveResources(at: endpoint)
    }

    func retrieveResource(with urlString: String) {
        let endpoint = Swapi.pagedUrl(urlString: urlString)
        retrieveResources(at: endpoint)
    }

    private func retrieveResources(at endpoint: Endpoint) {
        let fetch = SwapiFetchOperation(with: endpoint)
        let decode = SwapiDecodeOperation(for: endpoint.resource)

        let adapter = BlockOperation { [unowned fetch, unowned decode] in
            decode.jsonData = fetch.data
        }

        adapter.addDependency(fetch)
        decode.addDependency(adapter)

        decode.completionBlock = { [unowned decode, unowned self] in
            if decode.resourceHasMorePages {
                self.retrieveResource(with: decode.nextUrl)
            }
        }

        operationQueue.addOperations([fetch, decode, adapter], waitUntilFinished: true)
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
