//
//  CharacterDataSource.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 1/4/18.
//  Copyright © 2018 Nathan. All rights reserved.
//

import UIKit

class CharacterDetailDataSource: NSObject, UITableViewDataSource, ResourceUpdatable {

    private var character: Character
    private let swDetailIdentifier = "swDetail"
    private let swSimpleIdentifier = "swSimple"
    init(with character: Character) {
        self.character = character
        print("Character added to data source: \(character.basicInfo[0])")
        super.init()
    }

    func update(with item: Character) {
        self.character = item
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {

        case 0:
            return character.basicInfo.count
        case 1:
            return character.films.count
        case 2:
            return character.starships.count
        case 3:
            return character.vehicles.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {

        case 0:
            return "Basic Info"
        case 1:
            return "Appears In"
        case 2:
            return "Starships"
        case 3:
            return "Vehicles"
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            if indexPath.section == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: swDetailIdentifier) else {
                    return UITableViewCell(style: .value1, reuseIdentifier: swDetailIdentifier)
                }
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: swSimpleIdentifier) else {
                    return UITableViewCell(style: .default, reuseIdentifier: swSimpleIdentifier)
                }
                return cell
            }
        }()
        
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = #colorLiteral(red: 1, green: 0.8431372549, blue: 0, alpha: 1)

        let selectedCellView = UIView()
        selectedCellView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        cell.selectedBackgroundView = selectedCellView

        switch indexPath.section {
        case 0:
            cell.detailTextLabel?.text = character.basicInfo[indexPath.row].value as? String ?? ""
            cell.textLabel?.text = character.basicInfo[indexPath.row].label

        case 1:
            cell.textLabel?.text = character.films[indexPath.row].title
        case 2:
            cell.textLabel?.text = character.starships[indexPath.row].name
        case 3:
            cell.textLabel?.text = character.vehicles[indexPath.row].name
        default:
            cell.textLabel?.text = "Error?"
        }
        configureAppearance(for: cell)
        return cell
    }

    private func configureAppearance(for cell: UITableViewCell) {
        print("Configuring cell colors")
        cell.textLabel?.textColor = UIColor(named: "BlueAccent")
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        cell.detailTextLabel?.textColor = .white
    }

}
