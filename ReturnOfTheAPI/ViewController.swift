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
        let client = SwapiClient()
        // Do any additional setup after loading the view, typically from a nib.
//        do {
//            let realm = try Realm()
//            client.saveCharacter(resourceId: 2, to: realm)
//            let characters = realm.objects(Character.self)
//            print(characters)
//        } catch {
//            print(error)
//        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
