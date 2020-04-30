//
//  AppDelegate.swift
//  KeyboardManagerDemo
//
//  Created by Edouard Siegel on 03/03/16.
//
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // swiftlint:disable:previous discouraged_optional_collection
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        let navigationController = UINavigationController(rootViewController: MainTableViewController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }

}
