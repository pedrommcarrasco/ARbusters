//
//  HomeCoordinator.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 09/10/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import Foundation

// MARK: - HomeCoordinator
final class HomeCoordinator: Coordinator {

    // MARK: Properties
    var coordinators: [Coordinator] = []
    weak var coordinatorDelegate: CoordinatorDelegate?

    // MARK: Private Properties
    private let dependencies: DependencyContainer
    private let navigator: NavigatorRepresentable

    // MARK: Init
    init(with dependencies: DependencyContainer, navigator: NavigatorRepresentable) {

        self.dependencies = dependencies
        self.navigator = navigator
    }
}

// MARK: - Functions
extension HomeCoordinator {

    func start() {
        coordinatorDelegate?.coordinatorDidStart(self)
        navigator.transition(to: buildViewController(), as: .root)
    }
}

// MARK: - Utils
private extension HomeCoordinator {

    // MARK: Build ViewController
    func buildViewController() -> HomeViewController {
        let viewController = HomeViewController(dependencies: dependencies)
        viewController.navigationDelegate = self

        return viewController
    }
}

// MARK: - HomeViewControllerNavigationDelegate
extension HomeCoordinator: HomeViewControllerNavigationDelegate {

    func didPressPlay(in controller: HomeViewController) {
        navigateToGame()
    }

    func didPressHighestScore(in controller: HomeViewController) {
        navigateToHighScore()
    }
}

// MARK: - Navigation
private extension HomeCoordinator {

    private func navigateToGame() {

        let gameCoordinator = GameCoordinator(with: dependencies, navigator: navigator)
        gameCoordinator.coordinatorDelegate = self
        gameCoordinator.start()
    }

    private func navigateToHighScore() {

        let highScoreCoordinator = HighScoreCoordinator(with: dependencies, navigator: navigator)
        highScoreCoordinator.coordinatorDelegate = self
        highScoreCoordinator.start()
    }
}
