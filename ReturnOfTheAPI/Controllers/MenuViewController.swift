//
//  ViewController.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 10/27/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import UIKit
import RealmSwift

class MenuViewController: UIViewController {

    let characterButton = UIButton(type: .custom)
    let starshipButton = UIButton(type: .custom)
    let vehicleButton = UIButton(type: .custom)

    var stack: UIStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupButtons()
        configure(stack: stack)
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func setupButtons() {
        characterButton.setImage(#imageLiteral(resourceName: "icon-characters"), for: .normal)
        starshipButton.setImage(#imageLiteral(resourceName: "icon-starships"), for: .normal)
        vehicleButton.setImage(#imageLiteral(resourceName: "icon-vehicles"), for: .normal)
        characterButton.setTitle("Characters", for: .normal)
        starshipButton.setTitle("Starships", for: .normal)
        vehicleButton.setTitle("Vehicles", for: .normal)
        characterButton.centerVertically()
        starshipButton.centerVertically()
        vehicleButton.centerVertically()

        characterButton.addTarget(self, action: #selector(showResourceList), for: .touchUpInside)
        starshipButton.addTarget(self, action: #selector(showResourceList), for: .touchUpInside)
        vehicleButton.addTarget(self, action: #selector(showResourceList(sender:)), for: .touchUpInside)
    }

    @objc func showResourceList(sender: UIButton!) {
        guard let title = sender.currentTitle else {
            return
        }

        switch title {
        case "Characters":
            let swapiVC = SwapiViewController<CharacterList>()
            swapiVC.title = title
            self.navigationController?.pushViewController(swapiVC, animated: true)
        case "Starships":
            let swapiVC = SwapiViewController<StarshipList>()
            swapiVC.title = title
            self.navigationController?.pushViewController(swapiVC, animated: true)
        case "Vehicles":
            let swapiVC = SwapiViewController<VehicleList>()
            swapiVC.title = title
            self.navigationController?.pushViewController(swapiVC, animated: true)
        default:
            return
        }
    }

    func configure(stack: UIStackView) {
        view.addSubview(stack)
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(characterButton)
        stack.addArrangedSubview(starshipButton)
        stack.addArrangedSubview(vehicleButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stack.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            stack.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
            ])
    }
}
