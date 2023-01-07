//
//  AppDelegate.swift
//  RickAndMorty
//
//  Created by Robert Shrestha on 1/7/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator: CharacterCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // MARK: Main Coordinator
        let navController = UINavigationController()


        // MARK: Manual launch of app
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
        coordinator = CharacterCoordinator(navigationController: navController)
        coordinator?.start()
        return true
    }
}

