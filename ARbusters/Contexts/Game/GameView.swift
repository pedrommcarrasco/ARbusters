//
//  GameView.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 10/10/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit
import Constrictor
import ARKit

// MARK: - GameViewDelegate
protocol GameViewDelegate: class {

    // MARK: Functions
    func didCrash(in gameView: GameView)
}

// MARK: - GameView
class GameView: UIView {

    // MARK: Constants
    private enum Constant {
        static let anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }

    // MARK: Outlets
    private let gameView = ARSKView()
    private let gameInterfaceView = GameInterfaceView()

    // MARK: Properties
    weak var delegate: (GameViewDelegate & GameInterfaceViewDelegate)? {
        didSet { gameInterfaceView.delegate = delegate}
    }
    weak var logicDelegate: GameSceneProtocol?

    // MARK: Initializers
    init(logicDelegate: GameSceneProtocol) {
        self.logicDelegate = logicDelegate

        super.init(frame: .zero)

        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configuration
private extension GameView {

    func configure() {

        addSubviews()
        defineConstraints()
    }

    func addSubviews() {

        addSubviews(gameView, gameInterfaceView)
    }

    func defineConstraints() {

        gameView
            .constrictEdgesToParent(withinGuides: false)

        gameInterfaceView
            .constrictEdgesToParent()
    }

    func setupViews() {

        let scene = GameScene(size: gameView.bounds.size)
        scene.scaleMode = .resizeFill
        scene.anchorPoint = Constant.anchorPoint
        scene.controllerDelegate = logicDelegate
        gameView.delegate = self

        gameView.presentScene(scene)
    }
}

// MARK: - Actions
extension GameView {

    func willAppear() {
        gameView.session.run(ARWorldTrackingConfiguration())
    }

    func willDisappear() {
        gameView.session.pause()
    }

    func updateTime(with time: Int) {
        gameInterfaceView.updateTime(with: time)
    }
}

extension GameView: ARSKViewDelegate {

    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        guard let anchor = anchor as? Anchor, let type = anchor.type else { return nil }

        let node = type.asSprite()
        node.name = type.rawValue

        return node
    }

    func sessionInterruptionEnded(_ session: ARSession) {
        guard let configuration = session.configuration else { return }

        gameView.session.run(configuration, options: [.resetTracking,.removeExistingAnchors])
    }

    func session(_ session: ARSession, didFailWithError error: Error) {
        delegate?.didCrash(in: self)
    }
}
