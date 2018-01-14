//
//  GameScene.swift
//  ARniegeddon
//
//  Created by Pedro Carrasco on 10/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import ARKit


protocol GameSceneProtocol: class {
    func createdAnchor(anchor: Anchor)
    func userDidKill(anchor: Anchor)
    func userPickedBuff(anchor: Anchor)
    func userDidShotWithBuff()
}

class GameScene: SKScene {

    // MARK: - PROPERTIES
    weak var controllerDelegate: GameSceneProtocol?
    var sceneView: ARSKView { return view as! ARSKView}
    let gameSize = CGSize(width: 2, height: 2)
    var isAugmentedRealityReady = false

    // MARK: - PROPERTIES ( GAME LOGIC )
    var sight: SKSpriteNode! = NodeType.sight.asSprite()
    var hasBuff = false

    // MARK: - LIFECYCLE
    override func update(_ currentTime: TimeInterval) {
        if !isAugmentedRealityReady {
            setupWorld()
        }

        setupLight()
        detectIfPickedAntiBossWeapon()
}

    // MARK: - LIFECYCLE
    override func didMove(to view: SKView) {
        srand48(Int(Date.timeIntervalSinceReferenceDate))
        addChild(self.sight)
    }

    // MARK: - SETUP
    private func setupWorld() {
        guard let currentFrame = sceneView.session.currentFrame
            else { return }

        createEnemies(in: currentFrame)

        isAugmentedRealityReady = true
    }

    private func setupLight() {
        guard let currentFrame = sceneView.session.currentFrame,
            let lightEstimate = currentFrame.lightEstimate else { return }
        
        let neutralIntensity: CGFloat = 750
        let ambientIntensity = min(lightEstimate.ambientIntensity, neutralIntensity)

        let blendFactor = 1 - ambientIntensity/neutralIntensity

        for node in children {
            guard let ghost = node as? SKSpriteNode else { return }
            ghost.color = .black
            ghost.colorBlendFactor = blendFactor
        }
    }

    // MARK: - NODES  SETUP
    private func createEnemies(in frame: ARFrame) {
        guard let scene = SKScene(fileNamed: "LevelOne") else { return }

        for node in scene.children {
            if let type = createAnchor(in: scene, with: frame, at: node),
                type == .boss {

                createAntiBossWeapon(in: frame)
            }
        }
    }

    private func createAnchor(in scene: SKScene, with frame: ARFrame, at node: SKNode) -> NodeType? {
        guard let name = node.name,
            let type = NodeType(rawValue: name) else { return nil }

        var translation = matrix_identity_float4x4

        let x = node.position.x / scene.size.width
        let y = node.position.y / scene.size.height

        translation.columns.3.x = Float(x * gameSize.width)
        translation.columns.3.y = Float(drand48() - 0.5)
        translation.columns.3.z = Float(y * gameSize.height)

        let transform = frame.camera.transform * translation

        let anchor = Anchor(transform: transform)

        anchor.type = type
        sceneView.session.add(anchor: anchor)
        controllerDelegate?.createdAnchor(anchor: anchor)

        return type
    }

    private func createAntiBossWeapon(in frame: ARFrame) {
        var translation = matrix_identity_float4x4

        translation.columns.3.x = Float(drand48()*2 - 1)
        translation.columns.3.z = -Float(drand48()*2 - 1)
        translation.columns.3.y = Float(drand48() - 0.5)

        let transform = frame.camera.transform * translation

        let anchor = Anchor(transform: transform)
        anchor.type = .antiBossBuff

        sceneView.session.add(anchor: anchor)
        controllerDelegate?.createdAnchor(anchor: anchor)
    }

    // MARK: - USER INTERACTION
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {

        run(Sounds.fire)
        guard let hitEnemie = shot() else { return }
        killEnemie(from: hitEnemie)

    }

    private func shot() -> SKNode? {
        let location = sight.position
        let hitNodes = nodes(at: location)

        var hitEnemie: SKNode?
        for node in hitNodes {
            if node.name == NodeType.ghost.rawValue ||
                (node.name == NodeType.boss.rawValue && hasBuff) {
                hitEnemie = node
                break
            }
        }

        if hasBuff {
            controllerDelegate?.userDidShotWithBuff()
        }

        hasBuff = false

        return hitEnemie
    }

    private func killEnemie(from node: SKNode?) {
        guard let hitEnemie = node,
            let anchor = sceneView.anchor(for: hitEnemie) as? Anchor else { return }

        let action = SKAction.run {
            self.sceneView.session.remove(anchor: anchor)
        }

        let group = SKAction.group([Sounds.hit, action])
        let sequence = [SKAction.wait(forDuration: 0.25), group]
        hitEnemie.run(SKAction.sequence(sequence))

        controllerDelegate?.userDidKill(anchor: anchor)
    }

    private func detectIfPickedAntiBossWeapon() {
        guard let frame = sceneView.session.currentFrame else { return }
        for anchor in frame.anchors {

            guard let node = sceneView.node(for: anchor),
                node.name == NodeType.antiBossBuff.rawValue,
                let anchor = anchor as? Anchor
                else { continue }

            let distance = simd_distance(anchor.transform.columns.3,
                                         frame.camera.transform.columns.3)

            if distance < 0.1 {
                pickupAntiBossWeapon(anchor)
                break
            }
        }
    }

    private func pickupAntiBossWeapon(_ anchor: Anchor) {
        run(Sounds.bugspray)
        sceneView.session.remove(anchor: anchor)
        hasBuff = true

        controllerDelegate?.userPickedBuff(anchor: anchor)
    }
}
