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
        addChild(self.sight)
    }

    // MARK: - SETUP
    private func setupWorld() {
        guard let currentFrame = sceneView.session.currentFrame
            else { return }

        isAugmentedRealityReady = true
        createAnchor(in: currentFrame)
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

    private func createAnchor(in frame: ARFrame) {
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -0.5
        let transform = frame.camera.transform*translation

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
