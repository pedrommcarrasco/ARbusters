//
//  AppDelegate.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 10/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Properties
    var window: UIWindow?

    // MARK: Private Properties
    private var appCoordinator: AppCoordinator?
    private lazy var dependencies = DependencyContainer()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        setupCoordinator(in: window)

        return true
    }
}

// MARK: - Private Functions
private extension AppDelegate {

    // MARK: Coordinator
    func setupCoordinator(in window: UIWindow?) {
        guard let window = window else { return }
        appCoordinator = AppCoordinator(with: window, dependencyContainer: dependencies)
        appCoordinator?.start()
        window.makeKeyAndVisible()
    }
}
