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

    @IBOutlet weak var shortLabel: UILabel!
    @IBOutlet weak var tallLabel: UILabel!

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
        let segmentControl = UISegmentedControl(items: ["Imperial", "Metric"])
        let barButtonItem = UIBarButtonItem(customView: segmentControl)
        navigationItem.rightBarButtonItem = barButtonItem
        tableView.backgroundColor = .black
        tableView.dataSource = dataSource
        tableView.delegate = self
        shortLabel.text = SwapiClient.smallest(.character)
        tallLabel.text = SwapiClient.largest(.character)

//        self.tableView.tableHeaderView?.layoutIfNeeded()

        if basicInfoTable != nil && character != nil {
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
