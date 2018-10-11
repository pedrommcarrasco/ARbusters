//
//  Navigator.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 10/08/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

// MARK: - Representable
protocol NavigatorRepresentable {

    // MARK: Properties
    var root: UINavigationController { get }

    // MARK: Functions
    func transition(to viewController: UIViewController, as type: NavigationTransition)
    func dismiss()
    func pop()

    func displayBar()
    func hideBar()
}

// MARK: - Navigator
struct Navigator {

    // MARK: Private Properties
    private let navigationController: UINavigationController

    // MARK: Init
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: - NavigatorRepresentable's Conformance
extension Navigator: NavigatorRepresentable {

    // MARK: Navigation
    var root: UINavigationController {
        return navigationController
    }

    func transition(to viewController: UIViewController, as type: NavigationTransition) {
        switch type {
        case .root:
            navigationController.viewControllers = [viewController]
        case .push:
            navigationController.pushViewController(viewController, animated: true)
        case .modal:
            navigationController.present(viewController, animated: true, completion: nil)
        }
    }

    func dismiss() {
        navigationController.dismiss(animated: true, completion: nil)
    }

    func pop() {
        navigationController.popViewController(animated: true)
    }

    // MARK: NavigationBar
    func hideBar() {
        navigationBarHidden(true)
    }

    func displayBar() {
        navigationBarHidden(false)
    }
}

// MARK: - Private
private extension Navigator {

    // MARK: NavigationBar's hidden status
    func navigationBarHidden(_ status: Bool = true) {
        navigationController.setNavigationBarHidden(status, animated: false)
    }
}
