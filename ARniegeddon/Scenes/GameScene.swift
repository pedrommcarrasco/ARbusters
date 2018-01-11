//
//  GameScene.swift
//  ARniegeddon
//
//  Created by Pedro Carrasco on 10/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import ARKit

class GameScene: SKScene {

    // MARK: - PROPERTIES
    var sceneView: ARSKView { return view as! ARSKView}
    var sight: SKSpriteNode! = GamesImages.sight.asSprite()
    let gameSize = CGSize(width: 2, height: 2)
    var isAugmentedRealityReady = false

    // MARK: - LIFECYCLE
    override func update(_ currentTime: TimeInterval) {
        if !isAugmentedRealityReady {
            setupWorld()
        }

        setupLight()
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
        
        let neutralIntensity: CGFloat = 1000
        let ambientIntensity = min(lightEstimate.ambientIntensity, neutralIntensity)

        let blendFactor = 1 - ambientIntensity/neutralIntensity

        for node in children {
            guard let bug = node as? SKSpriteNode else { return }
            bug.color = .black
            bug.colorBlendFactor = blendFactor
        }
    }

    private func createEnemies(in frame: ARFrame) {
        guard let scene = SKScene(fileNamed: "LevelOne") else { return }

        for node in scene.children {
            createAnchor(in: scene, with: frame, at: node)
        }
    }

    private func createAnchor(in scene: SKScene, with frame: ARFrame, at node: SKNode) {
        var translation = matrix_identity_float4x4

        let x = node.position.x / scene.size.width
        let y = node.position.y / scene.size.height

        translation.columns.3.x = Float(x * gameSize.width)
        translation.columns.3.y = Float(drand48() - 0.5)
        translation.columns.3.z = Float(y * gameSize.height)

        let transform = frame.camera.transform * translation
        let anchor = ARAnchor(transform: transform)

        sceneView.session.add(anchor: anchor)
    }

    // MARK: - USER INTERACTION
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {

        run(Sounds.fire)
        guard let hitBug = bugShot() else { return }
        killBug(from: hitBug)

    }

    private func bugShot() -> SKNode? {
        let location = sight.position
        let hitNodes = nodes(at: location)

        var hitBug: SKNode?
        for node in hitNodes {
            if node.name == GamesImages.bug.rawValue {
                hitBug = node
                break
            }
        }

        return hitBug
    }

    private func killBug(from node: SKNode?) {
        guard let hitbug = node,
            let anchor = sceneView.anchor(for: hitbug) else { return }

        let action = SKAction.run {
            self.sceneView.session.remove(anchor: anchor)
        }

        let group = SKAction.group([Sounds.hit, action])
        let sequence = [SKAction.wait(forDuration: 0.25), group]
        hitbug.run(SKAction.sequence(sequence))
    }
}
