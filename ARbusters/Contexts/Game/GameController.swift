//
//  GameController.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 10/10/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import Foundation

// MARK: - GameControllerDelegate
protocol GameControllerDelegate: class {

    func controller(_ gameController: GameController, didUpdateTimeTo time: Int)
    func didLose(accordingTo controller: GameController)
    func didWin(accordingTo controller: GameController, with time: Int)
}

// MARK: - GameController
final class GameController {

    // MARK: Constant
    private enum Constant {
        static let timeInterval: TimeInterval = 1
    }

    // MARK: Properties
    weak var delegate: GameControllerDelegate?

    var hasBuff = false

    // MARK: Private Properties
    private var anchors = [Anchor]()
    private (set) var timer = Timer()
    private var time = 0
}

// MARK: - Timer
extension GameController {

    func startTimer() {

        time = 0
        timer = Timer.scheduledTimer(timeInterval: Constant.timeInterval,
                                     target: self,
                                     selector: #selector(update),
                                     userInfo: nil,
                                     repeats: true)
    }


    func endTimer() {
        timer.invalidate()
    }

    @objc private func update() {

        time += 1
        delegate?.controller(self, didUpdateTimeTo: time)
    }
}

// MARK: - Rules
private extension GameController {

    var isVictory: Bool {
        return anchors.count == 0
    }
}

// MARK: - GameSceneProtocol
extension GameController: GameSceneProtocol {

    func gameDidStart(in gameScene: GameScene) {
        startTimer()
    }

    func gameScene(_ gameScene: GameScene, created anchor: Anchor) {
        anchors.append(anchor)
    }

    func gameScene(_ gameScene: GameScene, killed anchor: Anchor) {

        guard let index = anchors.index(of: anchor) else { return }
        anchors.remove(at: index)

        if isVictory {
            endTimer()
            delegate?.didWin(accordingTo: self, with: time)

        }
    }

    func gameScene(_ gameScene: GameScene, picked buff: Anchor) {

        hasBuff = true
        guard let index = anchors.index(of: buff) else { return }
        anchors.remove(at: index)
    }

    func didFailWithBuff(in gameScene: GameScene) {

        endTimer()
        delegate?.didLose(accordingTo: self)
    }
}
