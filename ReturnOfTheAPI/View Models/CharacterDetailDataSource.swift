//
//  CharacterDataSource.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 1/4/18.
//  Copyright © 2018 Nathan. All rights reserved.
//

import UIKit

class CharacterDetailDataSource: NSObject, UITableViewDataSource, ResourceUpdatable {

    private var character: Character?

    override init() {
        super.init()
    }

    init(with character: Character) {
        super.init()
        self.character = character
    }

    func update(with item: Character) {
        self.character = item
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {

        case 0:
            return character?.films.count ?? 0
        case 1:
            return character?.starships.count ?? 0
        case 2:
            return character?.vehicles.count ?? 0
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {

        case 0:
            return "Appears In"
        case 1:
            return "Starships"
        case 2:
            return "Vehicles"
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "swList", for: indexPath)
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = #colorLiteral(red: 1, green: 0.8431372549, blue: 0, alpha: 1)

        let selectedCellView = UIView()
        selectedCellView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        cell.selectedBackgroundView = selectedCellView

        switch indexPath.section {
        case 0:
            cell.textLabel?.text = character?.films[indexPath.row].title ?? "Title Not Found"
        case 1:
            cell.textLabel?.text = character?.starships[indexPath.row].name ?? "Starship Not Found"
        case 2:
            cell.textLabel?.text = character?.vehicles[indexPath.row].name ?? "Vehicle Not Found"
        default:
            cell.textLabel?.text = "Error?"
        }

        return cell
    }

}
