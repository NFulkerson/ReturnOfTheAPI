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
        let decoder = JSONDecoder()

        do {
            var list: ResourceList
            let realm = try Realm()
            list = try decoder.decode(ResourceList.self, from: data)

            if let url = list.paginationURL {
                resourceHasMorePages = true
                nextUrl = url
                print("Next url is: \(nextUrl)")
            } else {
                print("Finished paging data!")
            }
            switch swapiResourceType {
            case .character:
                let decodedObjects = try decoder.decode([Character].self, from: list.results)
                try? realm.write {
                    realm.add(decodedObjects, update: true)
                }
            case .film:
                let decodedObjects = try decoder.decode([Film].self, from: list.results)
                try? realm.write {
                    realm.add(decodedObjects, update: true)
                }
            case .planet:
                let decodedObjects = try decoder.decode([Planet].self, from: list.results)
                try? realm.write {
                    realm.add(decodedObjects, update: true)
                }
            case .species:
                let decodedObjects = try decoder.decode([Species].self, from: list.results)
                try? realm.write {
                    realm.add(decodedObjects, update: true)
                }
            case .starship:
                let decodedObjects = try decoder.decode([Starship].self, from: list.results)
                try? realm.write {
                    realm.add(decodedObjects, update: true)
                }
            case .vehicle:
                let decodedObjects = try decoder.decode([Vehicle].self, from: list.results)
                try? realm.write {
                    realm.add(decodedObjects, update: true)
                }
            }

        } catch {
            print(error)
        }
        print("Finished decode operation")
    }

}
