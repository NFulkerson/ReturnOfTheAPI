//
//  VehicleDetailDataSource.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 1/27/18.
//  Copyright © 2018 Nathan. All rights reserved.
//

import UIKit

class VehicleDetailDataSource: NSObject, UITableViewDataSource, ResourceUpdatable {
    private var vehicle: Vehicle
    private let swDetailIdentifier = "swDetail"
    private let swSimpleIdentifier = "swSimple"

    init(with vehicle: Vehicle) {
        self.vehicle = vehicle
        print("Vehicle costs \(vehicle.costInCredits)")
        super.init()
    }

    func update(with item: Vehicle) {
        self.vehicle = item
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
            return vehicle.basicInfo.count
        case 1:
            return vehicle.films.count
        case 2:
            return vehicle.pilots.count
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
            cell.textLabel?.text = vehicle.basicInfo[indexPath.row].label
            if cell.textLabel?.text == "Cost" {
                cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            }

            cell.detailTextLabel?.text = vehicle.basicInfo[indexPath.row].value as? String ?? ""

        case 1:
            cell.textLabel?.text = vehicle.films[indexPath.row].title
        case 2:
            cell.textLabel?.text = vehicle.pilots[indexPath.row].name
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
