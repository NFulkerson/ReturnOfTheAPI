//
//  SWAPIClient.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 11/2/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import UIKit
import RealmSwift

@objcMembers class SwapiClient: NSObject {
    fileprivate let downloader = JSONDownloader()
    lazy var operationQueue: OperationQueue = {
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

        decode.completionBlock = { [unowned decode, weak self] in
            if decode.resourceHasMorePages {
                if let weakSelf = self {
                    weakSelf.retrieveResource(with: decode.nextUrl)
                } else {
                    print("We seem to have lost a reference")
                }
            }

            self?.networkIndicator(visible: false)
        }
        networkIndicator(visible: true)
        operationQueue.addOperations([fetch, decode, adapter], waitUntilFinished: true)
    }

    func howManyResources() -> Int {
        do {
            let realm = try Realm()
            let chars = realm.objects(Character.self).count
            let ships = realm.objects(Starship.self).count
            let vehicles = realm.objects(Vehicle.self).count
            let species = realm.objects(Species.self).count
            let films = realm.objects(Film.self).count
            let planets = realm.objects(Planet.self).count
            return chars + ships + vehicles + species + films + planets
        } catch {
            return 0
        }
    }

    func retrieveAllSwapiResources() {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.retrieveResources(for: .character)
            self?.retrieveResources(for: .film)
            self?.retrieveResources(for: .planet)
            self?.retrieveResources(for: .species)
            self?.retrieveResources(for: .vehicle)
            self?.retrieveResources(for: .starship)
        }
    }

   static func largest(_ resource: SwapiResource) -> String {
        do {
            let realm = try Realm()
            switch resource {
            case .character:
                let sortedChars = realm.objects(Character.self).sorted(byKeyPath: "rawHeight", ascending: false)
                print(sortedChars)
                if let tallest = sortedChars.first {
                    return tallest.name
                } else {
                    return ""
                }
            case .starship:
                if let largest = realm.objects(Starship.self).sorted(byKeyPath: "length").first {
                    return largest.name
                } else {
                    return ""
                }
            case .vehicle:
                if let largest = realm.objects(Vehicle.self).sorted(byKeyPath: "length").first {
                    return largest.name
                } else {
                    return ""
                }
            default:
                return ""
            }
        } catch {
            return ""
        }
    }

    static func find<T: Object>(_ resource: T.Type, named name: String) -> T? {
        do {
            let realm = try Realm()
            if let result = realm.objects(resource).filter("name = '\(name)'").first {
                return result
            }
        } catch {
            print(error)
        }
        return nil
    }

    static func smallest(_ resource: SwapiResource) -> String {
        do {
            let realm = try Realm()
            switch resource {
            case .character:
                if let shortest = realm.objects(Character.self).filter("rawHeight > 0").sorted(
                    byKeyPath: "rawHeight", ascending: true).first {
                    return shortest.name
                } else {
                    return ""
                }
            case .starship:
                if let shortest = realm.objects(Starship.self).sorted(byKeyPath: "length", ascending: true).first {
                    return shortest.name
                } else {
                    return ""
                }
            case .vehicle:
                if let shortest = realm.objects(Vehicle.self).sorted(byKeyPath: "length", ascending: true).first {
                    return shortest.name
                } else {
                    return ""
                }
            default:
                return ""
            }
        } catch {
            return ""
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

    private func networkIndicator(visible: Bool) {
        DispatchQueue.main.async {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.setNetworkIndicator(visible: visible)
            }
        }
    }

}
