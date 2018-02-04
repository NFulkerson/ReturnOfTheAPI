//
//  QuickFacts.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 2/4/18.
//  Copyright © 2018 Nathan. All rights reserved.
//

import UIKit

class QuickFactsView: UIView {
    var factsAboutResource: SwapiResource = .character
    var shouldSetupConstraints = true

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 50, height: 80)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    public convenience init(resource: SwapiResource) {
        self.init(frame: .zero)
        self.factsAboutResource = resource
    }

    override func updateConstraints() {
        if shouldSetupConstraints {
            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }

    func setupView() {
        let smallestDetailLabel = UILabel()
        let largestDetailLabel = UILabel()
        let smallestLabel = UILabel()
        let largestLabel = UILabel()
        smallestDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        largestDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        smallestLabel.translatesAutoresizingMaskIntoConstraints = false
        largestLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(smallestLabel)
        self.addSubview(largestLabel)
        self.addSubview(smallestDetailLabel)
        self.addSubview(largestDetailLabel)
        smallestDetailLabel.text = SwapiClient.smallest(factsAboutResource)
        largestDetailLabel.text = SwapiClient.largest(factsAboutResource)

        NSLayoutConstraint.activate([
            smallestLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 4.0),
            largestLabel.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 4.0),
            smallestLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0),
            largestLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0),
            smallestDetailLabel.centerYAnchor.constraint(equalTo: smallestLabel.centerYAnchor),
            largestDetailLabel.centerYAnchor.constraint(equalTo: largestLabel.centerYAnchor),
            smallestDetailLabel.leadingAnchor.constraint(equalTo: smallestLabel.trailingAnchor, constant: 16.0),
            largestDetailLabel.leadingAnchor.constraint(equalTo: largestLabel.trailingAnchor, constant: 16.0)
            ])

        smallestLabel.text = "Smallest"
        smallestLabel.textColor = .white
        largestLabel.text = "Largest"
        largestLabel.textColor = .white
        smallestDetailLabel.textColor = .white
        largestDetailLabel.textColor = .white
        largestDetailLabel.sizeToFit()
        smallestDetailLabel.sizeToFit()
        largestLabel.sizeToFit()
        smallestLabel.sizeToFit()
        self.layoutIfNeeded()
    }

}
