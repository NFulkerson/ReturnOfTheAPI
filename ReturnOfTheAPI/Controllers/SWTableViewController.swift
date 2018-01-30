//
//  SWTableViewController.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 1/4/18.
//  Copyright © 2018 Nathan. All rights reserved.
//

import UIKit
import RealmSwift

class SWTableViewController<Resource: ResourcePresentable>: UITableViewController {

    var shortLabel: UILabel!
    var tallLabel: UILabel!

    private var basicInfoTable: UITableViewController?
    var resource: Resource

    init(with resource: Resource) {
        self.resource = resource
        super.init(style: .plain)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let segmentControl = UISegmentedControl(items: ["Imperial", "Metric"])
        let barButtonItem = UIBarButtonItem(customView: segmentControl)
        navigationItem.rightBarButtonItem = barButtonItem
        tableView.backgroundColor = .black
        tableView.dataSource = self
        tableView.delegate = self
        shortLabel.text = SwapiClient.smallest(.character)
        tallLabel.text = SwapiClient.largest(.character)

//        self.tableView.tableHeaderView?.layoutIfNeeded()

//        if basicInfoTable != nil && resource != nil {
//            let infoTable = basicInfoTable as? BasicInfoTableViewController
//            infoTable?.setupLabels(for: resource)
//        }

    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let vc = segue.destination as? UITableViewController,
//            segue.identifier == "StaticTableEmbed" {
//            self.basicInfoTable = vc
//        }
//    }

}
