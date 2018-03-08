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

        performRequest(with: endpoint) { (data, error) in
            guard let json = data else {
                if let errorMessage = error {
                    let swapiError = SwapiError.operationError(message: errorMessage.localizedDescription)
                    swapiError.presentError()
                }
                return
            }
            let decode = SwapiDecodeOperation(for: endpoint.resource)
            decode.jsonData = json
            decode.completionBlock = {
                [unowned decode, weak self] in
                if decode.resourceHasMorePages {
                    print("Resource has another page: \(decode.nextUrl)")
                    guard let weakSelf = self else {
                        print("We lost a reference.")
                        return
                    }
                    weakSelf.retrieveResource(with: decode.nextUrl)
                }
                self?.networkIndicator(visible: false)
            }
            self.networkIndicator(visible: true)
            self.operationQueue.addOperation(decode)
        }
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
                print("Looking up tallest character.")
                let sortedChars = realm.objects(Character.self).sorted(byKeyPath: "rawHeight", ascending: false)
                if let tallest = sortedChars.first {
                    return tallest.name
                } else {
                    return ""
                }
            case .starship:
                print("Looking up longest starship.")
                let largest = realm.objects(Starship.self).sorted(byKeyPath: "length", ascending: false).first
                return largest?.name ?? ""
            case .vehicle:
                print("Looking up longest vehicle.")
                let largest = realm.objects(Vehicle.self).sorted(byKeyPath: "length", ascending: false).first
                return largest?.name ?? ""
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

            guard let data = data else {
                completion(nil, error)
                return
            }
            completion(data, nil)

        }
        task.resume()
    }

    static func find<T: Object>(_ resource: T.Type, named name: String) -> T? {
        do {
            let realm = try Realm()
            if let result = realm.objects(resource).filter("name = '\(name)'").first {
                return result
            }
        } catch {
            let error = SwapiError.resourceNotFound(
                message: "Could not find resource with given name.")
            error.presentError()
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
                if let shortest = realm.objects(Starship.self).filter("length > 0").sorted(byKeyPath: "length", ascending: true).first {
                    return shortest.name
                } else {
                    return ""
                }
            case .vehicle:
                if let shortest = realm.objects(Vehicle.self).filter("length > 0").sorted(byKeyPath: "length", ascending: true).first {
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

    private func networkIndicator(visible: Bool) {
        DispatchQueue.main.async {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.setNetworkIndicator(visible: visible)
            }
        }
    }

}
