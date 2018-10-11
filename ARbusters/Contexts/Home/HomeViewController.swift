//
//  HomeViewController.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 11/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit
import Constrictor

// MARK: - HomeViewControllerNavigationDelegate
protocol HomeViewControllerNavigationDelegate {

    // MARK: Functions
    func didPressPlay(in controller: HomeViewController)
    func didPressHighestScore(in controller: HomeViewController)
}

// MARK: - HomeViewController
class HomeViewController: UIViewController {
    typealias Dependencies = PersistenceDependency
    
    // MARK: Outlets
    private let homeView: HomeView

    // MARK: Properties
    var navigationDelegate: HomeViewControllerNavigationDelegate?

    // MARK: Private Properties
    private let dependencies: Dependencies

    // MARK: Initializer
    init(dependencies: Dependencies) {

        self.dependencies = dependencies
        self.homeView = HomeView()

        super.init(nibName: nil, bundle: nil)

        homeView.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        homeView.animateEntrance()
    }
}

// MARK: - Configuration
extension HomeViewController {

    override func loadView() {
        view = homeView
    }
}


// MARK: - HomeViewDelegate
extension HomeViewController: HomeViewDelegate {

    func didPressPlay(in view: HomeView) {
        navigationDelegate?.didPressPlay(in: self)
    }

    func didPressHighestScore(in view: HomeView) {
        navigationDelegate?.didPressHighestScore(in: self)
    }
}
