//
//  GameImages.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 10/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import ARKit

enum NodeType: String {
    case ghost = "ghost"
    case sight = "sight"
    case boss = "boss"
    case antiBossBuff = "antiBossBuff"
}

extension NodeType {
    func asSprite() -> SKSpriteNode {
        return SKSpriteNode(imageNamed: self.rawValue)
    }
}
