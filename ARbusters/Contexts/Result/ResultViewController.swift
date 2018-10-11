//
//  ResultViewController.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 14/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit
import Constrictor

// MARK: - ResultViewControllerNavigationDelegate
protocol ResultViewControllerNavigationDelegate: class {

    // MARK: Function
    func didPressOk(in controller: ResultViewController)
}

// MARK: - ResultViewController
class ResultViewController: UIViewController {
    typealias Static = ResultViewController
    typealias Dependencies = PersistenceDependency

    // MARK: Outlets
    private let resultView: ResultView

    // MARK: Properties
    weak var navigationDelegate: ResultViewControllerNavigationDelegate?

    // MARK: Private Properties
    private let dependencies: Dependencies

    // MARK: Initializer
    init(didWin: Bool, time: Int?, dependencies: Dependencies) {

        self.dependencies = dependencies
        self.resultView = ResultView(didWin: didWin,
                                     isNewRecord: Static.isNewRecord(time, persistence: dependencies.persistenceProvider),
                                     time: time)

        super.init(nibName: nil, bundle: nil)

        resultView.delegate = self

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        resultView.animateEntrance()
    }
}

// MARK: - Configuration
extension ResultViewController {
    
    override func loadView() {
        view = resultView
    }
}

// MARK: - ResultViewDelegate
extension ResultViewController: ResultViewDelegate {

    func didPressOk(in view: ResultView) {
        navigationDelegate?.didPressOk(in: self)
    }
}

// MARK: - Utils
private extension ResultViewController {

    static func isNewRecord(_ time: Int?, persistence: PersistenceProvidable) -> Bool {

        if let time = time { return persistence.isHighestScore(time)
        } else { return false }
    }
}

