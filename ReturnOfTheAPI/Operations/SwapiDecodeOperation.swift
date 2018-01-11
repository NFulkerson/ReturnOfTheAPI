//
//  SwapiDecodeOperation.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 11/17/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation
import RealmSwift

class SwapiDecodeOperation: Operation {
    var jsonData: Data?
    let swapiResourceType: SwapiResource
    var resourceHasMorePages: Bool = false
    var nextUrl: String = ""

    init(for swapiResource: SwapiResource) {
        print("Initializing operation")
        print("Swapi Resource is \(swapiResource)\nSetting resource type")
        self.swapiResourceType = swapiResource
    }

    override func main() {
        print("Decoding began")

        guard let data = jsonData else {
            print("No data :(")
            return
        }
        print("Entered main")
        if self.isCancelled {
            print("Canceled")
            return
        }

        do {
            let realm = try Realm()
            let decoder = JSONDecoder()
            switch swapiResourceType {
            case .character:
                let list = try decoder.decode(ResourceList<Character>.self, from: data)
                checkForMoreResources(in: list)
                print("Writing \(list.results.count) characters to realm.")
                write(results: list.results, to: realm)
            case .film:
                let list = try decoder.decode(ResourceList<Film>.self, from: data)
                checkForMoreResources(in: list)
                write(results: list.results, to: realm)
            case .planet:
                let list = try decoder.decode(ResourceList<Planet>.self, from: data)
                checkForMoreResources(in: list)
                write(results: list.results, to: realm)
            case .species:
                let list = try decoder.decode(ResourceList<Species>.self, from: data)
                checkForMoreResources(in: list)
                write(results: list.results, to: realm)
            case .starship:
                let list = try decoder.decode(ResourceList<Starship>.self, from: data)
                checkForMoreResources(in: list)
                write(results: list.results, to: realm)
            case .vehicle:
                let list = try decoder.decode(ResourceList<Vehicle>.self, from: data)
                checkForMoreResources(in: list)
                write(results: list.results, to: realm)
            }

        } catch {
            print(error)
        }
        print("Finished decode operation")
    }

    private func checkForMoreResources<T>(in list: ResourceList<T>) {
        if let url = list.paginationURL {
            resourceHasMorePages = true
            nextUrl = url
            print("Next url is: \(nextUrl)")
        } else {
            print("Finished paging data!")
        }
    }

    private func write<T>(results:[T], to realm: Realm) where T: Object {
        do {
            try realm.write {
                realm.add(results, update: true)
            }
        } catch {
            print(error)
        }
    }
}
