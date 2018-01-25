//
//  BasicInfoTableViewController.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 1/4/18.
//  Copyright © 2018 Nathan. All rights reserved.
//

import UIKit

class BasicInfoTableViewController: UITableViewController {
    @IBOutlet weak var bornLabel: UILabel!
    @IBOutlet weak var homeworldLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var hairColorLabel: UILabel!
    @IBOutlet weak var eyeColorLabel: UILabel!
    @IBOutlet weak var headerViewNameLabel: UILabel!

    @IBOutlet weak var heightCell: UITableViewCell!
    @IBOutlet weak var weightCell: UITableViewCell!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .black
        tableView.tableHeaderView?.backgroundColor = .black
        headerViewNameLabel.textColor = #colorLiteral(red: 1, green: 0.8429999948, blue: 0, alpha: 1)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                            forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }

    func setupLabels(for character: Character) {
        self.headerViewNameLabel.text = character.name
        self.bornLabel.text = character.birthYear
        self.homeworldLabel.text = character.homeworld?.name
        self.heightLabel.text = String(describing: character.height)
        self.weightLabel.text = String(describing: character.mass)
        self.genderLabel.text = character.gender
        self.hairColorLabel.text = character.hairColor
        self.eyeColorLabel.text = character.eyeColor
    }
}
