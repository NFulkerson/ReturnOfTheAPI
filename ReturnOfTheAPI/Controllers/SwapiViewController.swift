//
//  SwapiViewController.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 11/15/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import UIKit
import RealmSwift

class SwapiViewController<Resource: ResultPresentable>: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var listTableView: UITableView = UITableView()
    fileprivate var notificationToken: NotificationToken?

    var resource: Resource
    fileprivate var quickFacts: QuickFactsView?
    let client: SwapiClient = SwapiClient()

    init() {
        self.resource = Resource()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        quickFacts = QuickFactsView(resource: resource.resourceType)
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.backgroundColor = .black
        // only should do this once, or if data is incomplete.
        listTableView.register(UITableViewCell.self, forCellReuseIdentifier: "listCell")
        retrieveAllSwapiResources()
        setupConstraints()
        setupNotificationToken()

    }

    override func viewWillAppear(_ animated: Bool) {
        guard let facts = quickFacts else {
            return
        }
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        facts.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(facts)
        listTableView.tableHeaderView = container

        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: listTableView.centerXAnchor),
            container.widthAnchor.constraint(equalTo: listTableView.widthAnchor),
            container.topAnchor.constraint(equalTo: listTableView.topAnchor),
            container.heightAnchor.constraint(equalToConstant: CGFloat(100.0)),
            facts.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            facts.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            facts.widthAnchor.constraint(equalTo: container.widthAnchor),
            facts.heightAnchor.constraint(equalTo: container.heightAnchor)
            ])
        listTableView.tableHeaderView?.layoutIfNeeded()
        listTableView.tableHeaderView = listTableView.tableHeaderView
    }

    private func setupConstraints() {
        view.addSubview(listTableView)
        listTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            listTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            listTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            listTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            listTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
            ])

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = resource.items[indexPath.row]
        print("Did Select Row at \(indexPath.row)")
        print("Resource at index name: \(resource.items[indexPath.row])")
        let detailController = SWTableViewController(with: item)
        detailController.setQuickFacts(resource: resource.resourceType)
        self.navigationController?.pushViewController(detailController, animated: true)
    }

    private func setupNotificationToken() {
        if notificationToken == nil {
            self.notificationToken = resource.items.observe { [weak self] (changes: RealmCollectionChange) in
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
        return resource.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        configure(cell)

        cell.textLabel?.text = resource.items[indexPath.row].name

        return cell
    }

    // - MARK: SWAPI data methods

    private func retrieveAllSwapiResources() {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.client.retrieveResources(for: .character)
            self?.client.retrieveResources(for: .film)
            self?.client.retrieveResources(for: .planet)
            self?.client.retrieveResources(for: .species)
            self?.client.retrieveResources(for: .vehicle)
            self?.client.retrieveResources(for: .starship)
        }
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
