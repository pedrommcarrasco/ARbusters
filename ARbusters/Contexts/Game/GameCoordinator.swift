//
//  GameCoordinator.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 10/10/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import Foundation

// MARK: - GameCoordinator
final class GameCoordinator: Coordinator {

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
extension GameCoordinator {

    func start() {
        coordinatorDelegate?.coordinatorDidStart(self)
        navigator.transition(to: buildViewController(), as: .push)
    }
}

// MARK: - Utils
private extension GameCoordinator {

    // MARK: Build ViewController
    func buildViewController() -> GameViewController {
        let viewController = GameViewController(dependencies: dependencies)
        viewController.navigationDelegate = self

        return viewController
    }
}

// MARK: - GameViewControllerNavigationDelegate
extension GameCoordinator: GameViewControllerNavigationDelegate {

    func didPressQuit(in controller: GameViewController) {
        dismiss()
    }

    func didFinishVictorious(in controller: GameViewController, with time: Int) {
        navigateToResults(didWin: true, with: time)
    }

    func didFinishDefeated(in controller: GameViewController) {
        navigateToResults(didWin: false)
    }
}

// MARK: - Navigation
private extension GameCoordinator {

    func dismiss() {

        navigator.back()
        coordinatorDelegate?.coordinatorDidEnd(self)
    }

    func navigateToResults(didWin: Bool, with time: Int? = nil) {

        let resultCoordinator = ResultCoordinator(with: dependencies, navigator: navigator, didWin: true, time: time)
        resultCoordinator.coordinatorDelegate = self
        resultCoordinator.start()
    }
}
