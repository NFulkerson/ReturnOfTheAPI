//
//  SwapiViewController.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 11/15/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import UIKit
import RealmSwift

class SwapiViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var itemPicker: UIPickerView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bornLabel: UILabel!

    fileprivate var notificationToken: NotificationToken?

    var items: Results<Starship>?
    let client: SwapiClient = SwapiClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        itemPicker.delegate = self
        itemPicker.dataSource = self
        itemPicker.backgroundColor = .black

        nameLabel.textColor = UIColor.CustomColor.swYellow

        client.retrieveResources(for: .starship)

        do {
            let realm = try Realm()
            items = realm.objects(Starship.self).sorted(byKeyPath: "name", ascending: true)

        } catch {
            print(error)
        }

        notificationToken = items?.observe { [weak self] (changes: RealmCollectionChange) in
            guard let picker = self?.itemPicker else {
                return
            }
            switch changes {
            case .initial, .update:
                picker.reloadAllComponents()
            case .error(let error):
                print("Error! \(error)")
                fatalError()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let items = items else {
            return 0
        }
        return items.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let items = items else {
            return ""
        }
        return items[row].name
    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int,
                    forComponent component: Int) -> NSAttributedString? {
        guard let items = items else {
            return NSAttributedString(string: "")
        }
        return NSAttributedString(string: items[row].name,
                                  attributes: [NSAttributedStringKey.foregroundColor: UIColor.CustomColor.swYellow])
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let items = items else {
            return
        }
        nameLabel.text = items[row].name
        bornLabel.text = items[row].manufacturer
    }

}
