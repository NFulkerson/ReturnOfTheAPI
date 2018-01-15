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

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .black
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                            forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }

    func setupLabels(for character: Character) {
        self.bornLabel.text = character.birthYear
        self.homeworldLabel.text = character.homeworld?.name
        self.heightLabel.text = character.height
        self.weightLabel.text = character.mass
        self.genderLabel.text = character.gender
        self.hairColorLabel.text = character.hairColor
        self.eyeColorLabel.text = character.eyeColor
    }
}
