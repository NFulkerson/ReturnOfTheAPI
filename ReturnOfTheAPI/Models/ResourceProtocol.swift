//
//  ResourceProtocol.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 1/25/18.
//  Copyright © 2018 Nathan. All rights reserved.
//

import Foundation
import RealmSwift

protocol ResultPresentable {
    associatedtype Resource: Object, ResourcePresentable
    var items: Results<Resource> { get }

    init()
}

protocol ResourcePresentable {
    var name: String { get set }
}