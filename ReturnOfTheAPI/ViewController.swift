//
//  ViewController.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 10/27/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let realm = try? Realm()

        if let realm = realm {
            saveCharacter(to: realm)
            let characters = realm.objects(Character.self)
            print(characters.first)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func testApi() {
        let client = SwapiClient()
        client.retrieveCharacter(with: 1) { character, error in
            guard let character = character else {
                print(error as Any)
                return
            }
            print(character.name)

        }
        var characterList: [Character] = []
//        var paginatedResults: Bool = false
        client.retrievePaginatedCharacters { characters, error in
            guard let characters = characters else {
                print(error as Any)
                return
            }
            characterList.append(contentsOf: characters)

        }
    }

    func saveCharacter(to realm: Realm) {
        let client = SwapiClient()
        client.retrieveCharacter(with: 1) { character, error in
            guard let character = character else {
                print("Ruh roh")
                print(error as Any)
                return
            }
            try? realm.write {
                realm.add(character)
            }
        }
    }

}
