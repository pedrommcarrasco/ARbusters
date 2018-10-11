//
//  AppCoordinator.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 09/10/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

// MARK: - AppCoordinator
final class AppCoordinator: Coordinator {

    // MARK: Properties
    var coordinators: [Coordinator] = []
    weak var coordinatorDelegate: CoordinatorDelegate?

    // MARK: Private Properties
    private let navigator = Navigator(with: NavigationController())
    private let dependencies: DependencyContainer

    // MARK: Init
    init(with window: UIWindow, dependencyContainer: DependencyContainer) {

        window.rootViewController = navigator.root
        window.makeKeyAndVisible()

        self.dependencies = dependencyContainer
    }
}

// MARK: - Functions
extension AppCoordinator {

    func start() {

        let homeCoordinator = HomeCoordinator(with: dependencies, navigator: navigator)
        homeCoordinator.coordinatorDelegate = self
        homeCoordinator.start()
    }
}
