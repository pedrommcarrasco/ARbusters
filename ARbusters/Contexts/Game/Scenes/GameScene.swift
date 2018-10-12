//
//  GameScene.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 10/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import ARKit

// MARK: - GameSceneProtocol
protocol GameSceneProtocol: class {

    // MARK: Properties
    var hasBuff: Bool { get set }

    // MARK: Functions
    func gameDidStart(in gameScene: GameScene)
    func gameScene(_ gameScene: GameScene, created anchor: Anchor)
    func gameScene(_ gameScene: GameScene, killed anchor: Anchor)
    func gameScene(_ gameScene: GameScene, picked buff: Anchor)
    func didFailWithBuff(in gameScene: GameScene)
}

// MARK; - GameScene
class GameScene: SKScene {

    // MARK: Constant
    private enum Constant {
        static let gameSize = CGSize(width: 2, height: 2)
        static let level = SKScene(fileNamed: "LevelOne")
        static let buffMinimumDistance: Float = 0.1
        static let soundFxDelay = 0.25
    }

    // MARK: Nodes
    private let sight = NodeType.sight.asSprite()

    // MARK: Properties
    weak var controllerDelegate: GameSceneProtocol?

    private lazy var sceneView: ARSKView = {
        view as? ARSKView ?? ARSKView()
    }()

    private let gameSize = Constant.gameSize
    private var isConfigured = false
    private var hasBuff: Bool { return controllerDelegate?.hasBuff ?? false }

    // MARK: Lifecycle
    override func update(_ currentTime: TimeInterval) {

        if !isConfigured { configure() }

        configureLighting()
        pickBuffRoutine()
    }

    override func didMove(to view: SKView) {
        srand48(Int(Date.timeIntervalSinceReferenceDate))
        addChild(self.sight)
    }
}

// MARK: - Configuration
private extension GameScene {

    func configure() {

        guard let currentFrame = sceneView.session.currentFrame else { return }

        configureEnemies(in: currentFrame)

        isConfigured = true
    }

    private func configureLighting() {

        let blendFactor = GameLighting.blendFactor(lightEstimate: sceneView.session.currentFrame?.lightEstimate)

        children.forEach {
            let sprite = $0 as? SKSpriteNode
            sprite?.color = .black
            sprite?.colorBlendFactor = blendFactor
        }
    }

    private func configureEnemies(in frame: ARFrame) {
        guard let scene = Constant.level else { return }

        scene.children.forEach {
            guard let anchor = self.createAnchor(in: scene, with: frame, at: $0) else { return }

            if anchor.type == .boss {
                let buff = self.createBuff(in: frame)
                sceneView.session.add(anchor: buff)
                controllerDelegate?.gameScene(self, created: buff)
            }

            self.sceneView.session.add(anchor: anchor)
            self.controllerDelegate?.gameScene(self, created: anchor)
        }
    }
}

// MARK: - Creation
private extension GameScene {

    private func createAnchor(in scene: SKScene, with frame: ARFrame, at node: SKNode) -> Anchor? {

        guard let name = node.name, let type = NodeType(rawValue: name) else { return nil }

        let anchor = Anchor(
            transform: GameTransformation.enemyTransform(node, in: scene, with: gameSize, frame: frame)
        )

        anchor.type = type

        return anchor
    }

    private func createBuff(in frame: ARFrame) -> Anchor {

        let anchor = Anchor(transform: GameTransformation.buffTransform(frame: frame))
        anchor.type = .antiBossBuff

        return anchor
    }
}

// MARK: - User Interface Actions
extension GameScene {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        shot()
    }
}

// MARK: - Game Actions
private extension GameScene {

    func shot() {

        run(Sound.shot)

        let enemyHitted = hittedEnemy()
        if verifyIfFailedShotWithBuff(at: enemyHitted) { controllerDelegate?.didFailWithBuff(in: self) }

        controllerDelegate?.hasBuff = false

        guard let enemyShot = enemyHitted else { return }
        killEnemy(from: enemyShot)
    }
}

// MARK: - Routines
private extension GameScene {

    func pickBuffRoutine() {

        guard let frame = sceneView.session.currentFrame else { return }

        frame.anchors
            .filter { verifyIfPickedBuff($0, in: frame) }
            .forEach { self.pickupBuff($0) }
    }
}

// MARK: - Detections
private extension GameScene {

    func hittedEnemy() -> SKNode? {

        return nodes(at: sight.position).first { self.verifyIfHittedEnemy($0) }
    }
}

// MARK: - Verifications
private extension GameScene {

    func verifyIfPickedBuff(_ anchor: ARAnchor, in frame: ARFrame) -> Bool {

        guard sceneView.node(for: anchor)?.name == NodeType.antiBossBuff.rawValue else { return false }
        return simd_distance(anchor.transform.columns.3, frame.camera.transform.columns.3) < Constant.buffMinimumDistance
    }

    func verifyIfHittedEnemy(_ node: SKNode) -> Bool {
        return node.name == NodeType.ghost.rawValue || (node.name == NodeType.boss.rawValue && hasBuff)
    }

    func verifyIfFailedShotWithBuff(at enemy: SKNode?) -> Bool {
        return hasBuff && enemy?.name != NodeType.boss.rawValue
    }
}

// MARK: - Logic
private extension GameScene {

    private func killEnemy(from node: SKNode) {

        guard let anchor = sceneView.anchor(for: node) as? Anchor else { return }

        let action = SKAction.run { self.sceneView.session.remove(anchor: anchor) }
        let group = SKAction.group([Sound.hit, action])
        let sequence = [SKAction.wait(forDuration: Constant.soundFxDelay), group]
        node.run(SKAction.sequence(sequence))

        controllerDelegate?.gameScene(self, killed: anchor)
    }

    private func pickupBuff(_ anchor: ARAnchor) {

        run(Sound.buff)
        sceneView.session.remove(anchor: anchor)

        guard let anchor = anchor as? Anchor else { return }
        controllerDelegate?.gameScene(self, picked: anchor)
    }
}
