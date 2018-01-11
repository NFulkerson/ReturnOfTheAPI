//
//  SwapiViewController.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 11/15/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import UIKit
import RealmSwift

class SwapiViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var listTableView: UITableView!
    fileprivate var notificationToken: NotificationToken?

    var items: Results<Character>?
    let client: SwapiClient = SwapiClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.backgroundColor = .black
        // only should do this once, or if data is incomplete.
        retrieveAllSwapiResources()

        do {
            let realm = try Realm()
            items = realm.objects(Character.self).sorted(byKeyPath: "name", ascending: true)
            let test = realm.objects(Character.self)
            print(test)
        } catch {
            displayAlert(with: error.localizedDescription)
        }

        setupNotificationToken()

    }

    private func setupNotificationToken() {
        if notificationToken == nil {
            self.notificationToken = items?.observe { [weak self] (changes: RealmCollectionChange) in
                guard let table = self?.listTableView else {
                    return
                }
                switch changes {
                case .initial, .update:
                    table.reloadData()

                case .error(let error):
                    print("Error! \(error)")
                    fatalError()
                }
            }
        }
    }

    // - MARK: Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let items = items else {
            return 0
        }

        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        configure(cell)
        guard let items = items else {
            cell.textLabel?.text = ""
            return cell
        }

        cell.textLabel?.text = items[indexPath.row].name

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResourceDetailSegue" {
            if let indexPath = listTableView.indexPathForSelectedRow {
                let character = items?[indexPath.row]
                let detailController = segue.destination as? SWTableViewController
                guard let detail = detailController else {
                    displayAlert(with: "Couldn't load details.")
                    return
                }
                detail.character = character
            }
        }
    }

    // - MARK: SWAPI data methods

    private func retrieveAllSwapiResources() {
        // - TODO: These calls need to be performed async as they slow down the main thread
        client.retrieveResources(for: .character)
        client.retrieveResources(for: .film)
        client.retrieveResources(for: .planet)
        client.retrieveResources(for: .species)
        client.retrieveResources(for: .vehicle)
        client.retrieveResources(for: .starship)
    }

    private func configure(_ cell: UITableViewCell) {
        let selectedCellView = UIView()
        selectedCellView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        cell.selectedBackgroundView = selectedCellView
        cell.textLabel?.font = cell.textLabel?.font.withSize(22.0)
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = #colorLiteral(red: 0.348285228, green: 0.8181664348, blue: 1, alpha: 1)
    }

    func displayAlert(with error: String) {
        let errorAlert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        errorAlert.addAction(okAction)
        present(errorAlert, animated: true, completion: nil)
    }

}
