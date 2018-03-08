//
//  StarshipDetailDataSource.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 1/27/18.
//  Copyright © 2018 Nathan. All rights reserved.
//

import UIKit

class StarshipDetailDataSource: NSObject, UITableViewDataSource, ResourceUpdatable {

    private var starship: Starship
    private let swDetailIdentifier = "swDetail"
    private let swSimpleIdentifier = "swSimple"

    init(with starship: Starship) {
        self.starship = starship
        print("Starship costs \(starship.costInCredits)")
        super.init()
    }

    func update(with starship: Starship) {
        self.starship = starship
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Basic Info"
        case 1:
            return "Appears In"
        case 2:
            return "Pilots"
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return starship.basicInfo.count
        case 1:
            return starship.films.count
        case 2:
            return starship.pilots.count
        default:
            return 0
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

        switch indexPath.section {
        case 0:
            cell.textLabel?.text = starship.basicInfo[indexPath.row].label
            if cell.textLabel?.text == "Cost" {
                cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            }
            cell.detailTextLabel?.text = starship.basicInfo[indexPath.row].value as? String ?? "BORK"

        case 1:
            cell.textLabel?.text = starship.films[indexPath.row].title
        case 2:
            cell.textLabel?.text = starship.pilots[indexPath.row].name
        default:
            cell.textLabel?.text = "Error!"
        }
        configureAppearance(for: cell)
        return cell
    }

    private func configureAppearance(for cell: UITableViewCell) {
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = #colorLiteral(red: 1, green: 0.8431372549, blue: 0, alpha: 1)

        let selectedCellView = UIView()
        selectedCellView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        cell.selectedBackgroundView = selectedCellView

        cell.textLabel?.textColor = UIColor(named: "BlueAccent")
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        cell.detailTextLabel?.textColor = .white
    }
}
