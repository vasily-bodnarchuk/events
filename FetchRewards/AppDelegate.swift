//
//  AppDelegate.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/18/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var core: Core = CoreImpl.create()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        core.launch()
        return true
    }

}

