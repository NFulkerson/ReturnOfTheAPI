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

    var resource: Resource

    let swDetailIdentifier = "swDetail"
    let swSimpleIdentifier = "swSimple"

    init(with resource: Resource) {
        self.resource = resource
        super.init(style: .grouped)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented.")
    }

    override func viewWillAppear(_ animated: Bool) {
        let header = UIView()
        let henlo = UILabel()
        henlo.text = "Henlo"
        henlo.textColor = .white
        header.addSubview(henlo)
        henlo.sizeToFit()
        header.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableHeaderView = header

        NSLayoutConstraint.activate([
            henlo.centerXAnchor.constraint(equalTo: header.centerXAnchor),
            henlo.centerYAnchor.constraint(equalTo: header.centerYAnchor),
            header.widthAnchor.constraint(equalTo: tableView.widthAnchor),
            header.heightAnchor.constraint(equalToConstant: 80.0)
            ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let segmentControl = UISegmentedControl(items: ["Metric","Imperial"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(unitMeasureChanged(segment:)), for: .valueChanged)
        let barButtonItem = UIBarButtonItem(customView: segmentControl)
        navigationItem.rightBarButtonItem = barButtonItem
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        if resource is Character {
            return 4
        }
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if resource is Character {
            if let character = resource as? Character {
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

        } else if resource is Starship {
            if let starship = resource as? Starship {
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
        } else if resource is Vehicle {
            if let vehicle = resource as? Vehicle {
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
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Basic Info"
        case 1:
            return "Appears In"
        case 2:
            if resource is Character {
                return "Starships"
            }
            return "Pilots"
        case 3:
            return "Vehicles"
        default:
            return nil
        }
    }

    @objc private func unitMeasureChanged(segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            if let character = resource as? Character {
                character.providesUnitsIn = .metric
                self.tableView.reloadData()
            }
        } else if segment.selectedSegmentIndex == 1 {
            if let character = resource as? Character {
                character.providesUnitsIn = .imperial
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

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
        if let character = resource as? Character {
            switch indexPath.section {
            case 0:
                cell.detailTextLabel?.text = character.basicInfo[indexPath.row].value as? String ?? ""
                cell.detailTextLabel?.textColor = .white
                cell.textLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
                cell.textLabel?.text = character.basicInfo[indexPath.row].label
                cell.textLabel?.textColor = UIColor(named: "BlueAccent")
            case 1:
                cell.textLabel?.text = character.films[indexPath.row].title
            case 2:
                cell.textLabel?.text = character.starships[indexPath.row].name
            case 3:
                cell.textLabel?.text = character.vehicles[indexPath.row].name
            default:
                cell.textLabel?.text = "Error?"
            }
        } else if let ship = resource as? Starship {
            switch indexPath.section {
            case 0:
                cell.textLabel?.text = ship.basicInfo[indexPath.row].label
                cell.textLabel?.textColor = UIColor(named: "BlueAccent")
                cell.textLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)

                cell.detailTextLabel?.text = ship.basicInfo[indexPath.row].value as? String ?? ""
                cell.detailTextLabel?.textColor = .white
            case 1:
                cell.textLabel?.text = ship.films[indexPath.row].title
            case 2:
                cell.textLabel?.text = ship.pilots[indexPath.row].name
            default:
                cell.textLabel?.text = "Error!"
            }
        } else if let vehicle = resource as? Vehicle {
            switch indexPath.section {
            case 0:
                cell.textLabel?.text = vehicle.basicInfo[indexPath.row].label
                cell.textLabel?.textColor = UIColor(named: "BlueAccent")
                cell.textLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)

                cell.detailTextLabel?.text = vehicle.basicInfo[indexPath.row].value as? String ?? ""
                cell.detailTextLabel?.textColor = .white
            case 1:
                cell.textLabel?.text = vehicle.films[indexPath.row].title
            case 2:
                cell.textLabel?.text = vehicle.pilots[indexPath.row].name
            default:
                cell.textLabel?.text = "Error!"
            }
        }

        return cell
    }

}
