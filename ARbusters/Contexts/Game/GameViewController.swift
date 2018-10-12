//
//  GameViewController.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 10/10/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit
import ARKit

// MARK: - GameViewControllerNavigationDelegate
protocol GameViewControllerNavigationDelegate: class {

    // MARK: Function
    func didPressQuit(in controller: GameViewController)
    func didFinishVictorious(in controller: GameViewController, with time: Int)
    func didFinishDefeated(in controller: GameViewController)
}

// MARK: - GameViewController
class GameViewController: UIViewController {
    typealias Dependencies = PersistenceDependency & MusicDependency

    // MARK: Outlets
    private let gameView: GameView

    // MARK: Properties
    weak var navigationDelegate: GameViewControllerNavigationDelegate?

    // MARK: Private Properties
    private let dependencies: Dependencies
    private let controller = GameController()
    private var volumeAction = MusicVolumeAction.mute

    // MARK: Initializer
    init(dependencies: Dependencies) {
        self.gameView = GameView(logicDelegate: controller)

        self.dependencies = dependencies

        super.init(nibName: nil, bundle: nil)

        gameView.delegate = self
        controller.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        dependencies.musicProvider.apply(.start)
        gameView.willAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        gameView.willDisappear()
        controller.endTimer()
        dependencies.musicProvider.apply(.stop)
    }
}

// MARK: - Configuration
extension GameViewController {

    override func loadView() {
        view = gameView
    }
}

// MARK: - GameInterfaceViewDelegate
extension GameViewController: GameInterfaceViewDelegate {

    func didPressQuit(in view: GameInterfaceView) {
        navigationDelegate?.didPressQuit(in: self)
    }

    func didPressVolume(in view: GameInterfaceView) {

        dependencies.musicProvider.apply(volumeAction)
        volumeAction = volumeAction.invert()
    }
}

// MARK: - GameViewDelegate
extension GameViewController: GameViewDelegate {

    func didCrash(in gameView: GameView) {

        controller.endTimer()
        presentAlert()
    }
}

// MARK: - GameControllerDelegate
extension GameViewController: GameControllerDelegate {

    func controller(_ gameController: GameController, didUpdateTimeTo time: Int) {
        gameView.updateTime(with: time)
    }

    func didLose(accordingTo controller: GameController) {
        navigationDelegate?.didFinishDefeated(in: self)
    }

    func didWin(accordingTo controller: GameController, with time: Int) {
        navigationDelegate?.didFinishVictorious(in: self, with: time)
    }
}

// MARK: - Alertable
extension GameViewController: Alertable {}
