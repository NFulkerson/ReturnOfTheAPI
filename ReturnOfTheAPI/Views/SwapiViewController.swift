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
    var items: Results<Character>?

    override func viewDidLoad() {
        super.viewDidLoad()
        itemPicker.delegate = self
        itemPicker.dataSource = self
        itemPicker.backgroundColor = .black

        do {
            let realm = try Realm()
            items = realm.objects(Character.self)
        } catch {
            print(error)
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

}
