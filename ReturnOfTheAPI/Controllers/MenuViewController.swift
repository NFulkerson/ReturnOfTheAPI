//
//  ViewController.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 10/27/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import UIKit
import RealmSwift

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}
