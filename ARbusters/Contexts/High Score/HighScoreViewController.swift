//
//  HighScoreViewController.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 09/10/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

// MARK: - HighScoreViewControllerNavigationDelegate
protocol HighScoreViewControllerNavigationDelegate: class {

    // MARK: Function
    func didPressBack(in controller: HighScoreViewController)
}

// MARK: - HighScoreViewController
class HighScoreViewController: UIViewController {
    typealias Dependencies = PersistenceDependency

    // MARK: Outlets
    private let highScoreView: HighScoreView

    // MARK: - Properties
    weak var navigationDelegate: HighScoreViewControllerNavigationDelegate?

    // MARK: Initializer
    init(dependencies: Dependencies) {
        self.highScoreView = HighScoreView(with: dependencies.persistenceProvider.highestScore,
                                           didPlay: dependencies.persistenceProvider.highestScore != 0)

        super.init(nibName: nil, bundle: nil)

        self.highScoreView.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        highScoreView.animateEntrance()
    }
}

// MARK: - Configuration
extension HighScoreViewController {

    override func loadView() {
        view = highScoreView
    }
}

// MARK: - HighScoreViewDelegate
extension HighScoreViewController: HighScoreViewDelegate {

    func didPressBack(in view: HighScoreView) {
        navigationDelegate?.didPressBack(in: self)
    }
}
