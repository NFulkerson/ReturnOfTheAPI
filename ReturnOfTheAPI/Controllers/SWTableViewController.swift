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
    var dataSource: UITableViewDataSource

    fileprivate var quickFacts: QuickFactsView?
    let swDetailIdentifier = "swDetail"
    let swSimpleIdentifier = "swSimple"

    init(with resource: Resource) {
        self.resource = resource
        if resource is Character {
            dataSource = CharacterDetailDataSource(with: resource as! Character)
        } else if resource is Vehicle {
            dataSource = VehicleDetailDataSource(with: resource as! Vehicle)
        } else if resource is Starship {
            dataSource = StarshipDetailDataSource(with: resource as! Starship)
        } else {
            // ideally, we'd throw an error here and navigate back in our view hierarchy.
            // need to research
            fatalError("Resource is not a character, starship, or vehicle.")
        }

        super.init(style: .grouped)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented.")
    }

    override func viewWillAppear(_ animated: Bool) {

        guard let facts = quickFacts else {
            return
        }
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        facts.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(facts)
        tableView.tableHeaderView = container

        NSLayoutConstraint.activate([
            facts.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            facts.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            container.widthAnchor.constraint(equalTo: tableView.widthAnchor),
            container.heightAnchor.constraint(equalToConstant: 80.0)
            ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let segmentControl = UISegmentedControl(items: ["Metric", "Imperial"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(unitMeasureChanged(segment:)), for: .valueChanged)
        let barButtonItem = UIBarButtonItem(customView: segmentControl)
        navigationItem.rightBarButtonItem = barButtonItem
        if resource is Starship || resource is Vehicle {
            addCurrencyButton()
        }
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.reloadData()
    }

    private func addCurrencyButton() {
        let currencyBarButtonItem = UIBarButtonItem(title: "$", style: .plain, target: self, action: #selector(currencyConversionSelected))
        navigationItem.rightBarButtonItems?.append(currencyBarButtonItem)
    }

    @objc func currencyConversionSelected() {
        let currencyView = UIAlertController(title: "Exchange Rate", message: "Enter exchange rate between USD and Galactic Credits.", preferredStyle: .alert)
        currencyView.addTextField { (textField) in
            textField.text = "1.0"
        }
        currencyView.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { [weak currencyView] (_) in
            print("Hooray!: \(String(describing: currencyView?.textFields![0].text!))")
            let input = currencyView?.textFields?[0].text
            if self.resource is Valuable {
                if let valu = self.resource as? Valuable, let inputRate = input, let rate = Double(inputRate) {
                    if rate <= 0 {
                        let error = SwapiError.invalidData(message: "Exchange rate cannot be negative or zero.")
                        error.presentError()
                        return
                    }
                    valu.convertedToDollars(valu.costInCredits, rate: rate)
                    self.tableView.reloadData()
                }
            }
        }))
        present(currencyView, animated: true, completion: nil)
    }

    @objc private func unitMeasureChanged(segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            if var measured = resource as? UnitProvider {
                measured.providesUnitsIn = .metric
                tableView.reloadData()
            }
        } else if segment.selectedSegmentIndex == 1 {
            if var measured = resource as? UnitProvider {
                measured.providesUnitsIn = .imperial
                tableView.reloadData()
            }
        }
    }

    func setQuickFacts(resource: SwapiResource) {
        quickFacts = QuickFactsView(resource: resource)
    }


}
