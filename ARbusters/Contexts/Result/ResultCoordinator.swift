//
//  ResultCoordinator.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 09/10/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import Foundation

// MARK: - ResultCoordinator
final class ResultCoordinator: Coordinator {

    // MARK: Properties
    var coordinators: [Coordinator] = []
    weak var coordinatorDelegate: CoordinatorDelegate?

    // MARK: Private Properties
    private let dependencies: DependencyContainer
    private let navigator: NavigatorRepresentable
    private let didWin: Bool
    private let time: Int?

    // MARK: Init
    init(with dependencies: DependencyContainer, navigator: NavigatorRepresentable, didWin: Bool, time: Int?) {

        self.dependencies = dependencies
        self.navigator = navigator
        self.didWin = didWin
        self.time = time
    }
}

// MARK: - Functions
extension ResultCoordinator {

    func start() {
        coordinatorDelegate?.coordinatorDidStart(self)
        navigator.transition(to: buildViewController(), as: .push)
    }
}

// MARK: - Utils
private extension ResultCoordinator {

    // MARK: Build ViewController
    func buildViewController() -> ResultViewController {
        let viewController = ResultViewController(didWin: didWin, time: time, dependencies: dependencies)
        viewController.navigationDelegate = self

        return viewController
    }
}

extension ResultCoordinator: ResultViewControllerNavigationDelegate {

    func didPressOk(in controller: ResultViewController) {

        navigator.pop()
        coordinatorDelegate?.coordinatorDidEnd(self)
    }
}
