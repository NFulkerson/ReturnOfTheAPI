//
//  LoadingViewController.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 12/17/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import UIKit
import RealmSwift

class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let client = SwapiClient()

        client.retrieveResources(for: .starship)
        client.retrieveResources(for: .character)
        client.retrieveResources(for: .planet)
        client.retrieveResources(for: .film)
        client.retrieveResources(for: .species)
        client.retrieveResources(for: .vehicle)

    }
}
