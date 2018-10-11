//
//  HighScoreCoordinator.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 09/10/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import Foundation

// MARK: - HighScoreCoordinator
final class HighScoreCoordinator: Coordinator {

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
extension HighScoreCoordinator {

    func start() {
        coordinatorDelegate?.coordinatorDidStart(self)
        navigator.transition(to: buildViewController(), as: .modal)
    }
}

// MARK: - HomeViewControllerNavigationDelegate
extension HighScoreCoordinator: HighScoreViewControllerNavigationDelegate {

    func didPressBack(in controller: HighScoreViewController) {
        dismiss()
    }
}

// MARK: - Navigation
private extension HighScoreCoordinator {

    private func dismiss() {

        navigator.dismiss()
        coordinatorDelegate?.coordinatorDidEnd(self)
    }
}

// MARK: - Utils
private extension HighScoreCoordinator {

    // MARK: Build ViewController
    func buildViewController() -> HighScoreViewController {

        let viewController = HighScoreViewController(dependencies: dependencies)
        viewController.navigationDelegate = self
        viewController.modalPresentationStyle = .overCurrentContext

        return viewController
    }
}
