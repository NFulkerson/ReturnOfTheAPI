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
    let jsonData: Data
    let swapiResourceType: SwapiResource

    init(with data: Data, for swapiResource: SwapiResource) {
        print("Initializing operation")
        self.jsonData = data
        self.swapiResourceType = swapiResource
    }

    override func main() {
        print("Entered main")
        if self.isCancelled {
            print("Canceled")
            return
        }
        let decoder = JSONDecoder()

        do {
            let realm = try Realm()
            switch swapiResourceType {
            case .character:
                let list = try decoder.decode(CharacterList.self, from: jsonData)
                print("Preparing to write characters to database!")
                print(list.results)
                try? realm.write {
                    realm.add(list.results, update: true)
                }
                print(realm.objects(Character.self))
            case .starship:
                let list = try decoder.decode(StarshipList.self, from: jsonData)
                try? realm.write {
                    realm.add(list.results, update: true)
                }
            case .vehicle:
                let list = try decoder.decode(VehicleList.self, from: jsonData)
                try? realm.write {
                    realm.add(list.results, update: true)
                }
            default:
                throw SwapiError.decodingFailed(message: "Invalid resource")
            }

        } catch {
//            completion(nil, .decodingFailed(message: String(describing: error)))
            print(error)
        }

    }
}
