//
//  SWTableViewController.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 1/4/18.
//  Copyright © 2018 Nathan. All rights reserved.
//

import UIKit
import RealmSwift

class SWTableViewController: UITableViewController {
    private var basicInfoTable: UITableViewController?
    var character: Character? {
        didSet {
            if let character = character {
                dataSource.update(with: character)
                tableView.reloadData()
            }
        }
    }

    var dataSource = CharacterDetailDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = .black
        tableView.dataSource = dataSource
        tableView.delegate = self

        if basicInfoTable != nil && character != nil {
            print(character)
            let infoTable = basicInfoTable as? BasicInfoTableViewController
            infoTable?.setupLabels(for: character!)
        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? UITableViewController,
            segue.identifier == "StaticTableEmbed" {
            self.basicInfoTable = vc
        }
    }

}
