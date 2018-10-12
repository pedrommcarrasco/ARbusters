//
//  GameTransformation.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 12/10/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import ARKit

// MARK: - GameTransformation
struct GameTransformation {

    static func enemyTransform(_ node: SKNode, in scene: SKScene, with size: CGSize, frame: ARFrame) -> float4x4 {

        var translation = matrix_identity_float4x4

        let x = node.position.x / scene.size.width
        let y = node.position.y / scene.size.height

        translation.columns.3.x = Float(x * size.width)
        translation.columns.3.y = Float(drand48() - 0.5)
        translation.columns.3.z = Float(y * size.height)

        return frame.camera.transform * translation
    }

    static func buffTransform(frame: ARFrame) -> float4x4 {

        var translation = matrix_identity_float4x4

        translation.columns.3.x = Float(drand48() * 2 - 1)
        translation.columns.3.z = -Float(drand48() * 2 - 1)
        translation.columns.3.y = Float(drand48() - 0.5)

        return frame.camera.transform * translation
    }
}
