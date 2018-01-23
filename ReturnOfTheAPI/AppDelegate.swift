//
//  AppDelegate.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 10/27/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var activityIndicatorVisibleCount: Int = 0

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UIApplication.shared.statusBarStyle = .lightContent
        Realm.Configuration.defaultConfiguration.deleteRealmIfMigrationNeeded = true

        return true
    }
    // Idea/code gleaned from here: http://www.djbp.co.uk/swift-development-managing-the-network-activity-indicator/
    // Helps manage/prevent flickering of indicator
    func setNetworkIndicator(visible: Bool) {
        if visible {
            activityIndicatorVisibleCount += 1
        } else {
            activityIndicatorVisibleCount -= 1
        }

        if activityIndicatorVisibleCount < 0 {
            activityIndicatorVisibleCount = 0
        }

        UIApplication.shared.isNetworkActivityIndicatorVisible = activityIndicatorVisibleCount > 0
    }
}
