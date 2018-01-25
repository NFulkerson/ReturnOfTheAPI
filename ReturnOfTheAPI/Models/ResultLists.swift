//
//  ResultLists.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 1/25/18.
//  Copyright © 2018 Nathan. All rights reserved.
//

import Foundation
import RealmSwift

final class CharacterList: ResultPresentable {
    var items: Results<Character>

    init() {
        do {
            let realm = try Realm()
            items = realm.objects(Character.self).sorted(byKeyPath: "name", ascending: true)
        } catch {
            fatalError("Could not initialize results. \(error)")
        }
    }
}

final class StarshipList: ResultPresentable {
    var items: Results<Starship>

    init() {
        do {
            let realm = try Realm()
            items = realm.objects(Starship.self).sorted(byKeyPath: "name", ascending: true)
        } catch {
            fatalError("Could not initialize Starship results. \(error)")
        }
    }
}

final class VehicleList: ResultPresentable {
    var items: Results<Vehicle>

    init() {
        do {
            let realm = try Realm()
            items = realm.objects(Vehicle.self).sorted(byKeyPath: "name", ascending: true)
        } catch {
            fatalError("Could not initialize Vehicle results. \(error)")
        }
    }
}
