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
        
        do {
            var list: ResourceList
            let realm = try Realm()
            list = try ResourceList(from: swapiResourceType, data: data)

            if let url = list.paginationURL {
                resourceHasMorePages = true
                nextUrl = url
                print("Next url is: \(nextUrl)")
            } else {
                print("Finished paging data!")
            }

            switch swapiResourceType {
            case .character:
                let results = list.results as! [Character]
            case .film:
                let results = list.results as! [Film]
            case .planet:
                let results = list.results as! [Planet]
            case .species:
                let results = list.results as! [Species]
            case .starship:
                let results = list.results as! [Starship]
            case .vehicle:
                let results = list.results as! [Vehicle]

            }



        } catch {
            print(error)
        }
        print("Finished decode operation")
    }

}
