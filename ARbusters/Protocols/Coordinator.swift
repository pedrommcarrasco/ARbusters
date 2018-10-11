//
//  Coordinator.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 09/10/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import Foundation

// MARK: - Coordinator
protocol Coordinator: CoordinatorDelegate {

    // MARK: Properties
    var coordinatorDelegate: CoordinatorDelegate? { get set }
    var coordinators: [Coordinator] { get set }

    // MARK: Functions
    func start()
}

// MARK: - Coordinator's Default Implementation
extension Coordinator {
    func coordinatorDidStart(_ coordinator: Coordinator) {
        coordinators.append(coordinator)
    }

    func coordinatorDidEnd(_ coordinator: Coordinator) {
        coordinators = coordinators.filter { $0 !== coordinator }
    }
}

// MARK: - CoordinatorDelegate
protocol CoordinatorDelegate: class {

    // MARK: Functions
    func coordinatorDidStart(_ coordinator: Coordinator)
    func coordinatorDidEnd(_ coordinator: Coordinator)
}
