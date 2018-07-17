//
//  AppDelegate.swift
//  LightMigration
//
//  Created by Sushant on 12/07/18.
//  Copyright © 2018 Striker. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Migration.shared().isMigrationRequired()
        return true
    }


    func applicationWillTerminate(_ application: UIApplication) {
        Migration.shared().saveContext()
    }

    // MARK: - Core Data stack

   

}

