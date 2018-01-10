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
    var isAugmentedRealityReady = false

    // MARK: - LIFECYCLE
    override func update(_ currentTime: TimeInterval) {

        if !isAugmentedRealityReady {
            setupWorld()
        }
        
        setupLight()
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
}
