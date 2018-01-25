//
//  ResourceTableController.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 1/26/18.
//  Copyright © 2018 Nathan. All rights reserved.
//

import UIKit

class CharacterTableController: UITableViewController {
    let characters = CharacterList()


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return characters.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        configure(cell)

        cell.textLabel?.text = characters.items[indexPath.row].name

        return cell
    }

    private func configure(_ cell: UITableViewCell) {
        let selectedCellView = UIView()
        selectedCellView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        cell.selectedBackgroundView = selectedCellView
        cell.textLabel?.font = cell.textLabel?.font.withSize(22.0)
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = #colorLiteral(red: 0.348285228, green: 0.8181664348, blue: 1, alpha: 1)
    }

}
