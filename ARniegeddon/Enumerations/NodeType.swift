//
//  GameImages.swift
//  ARniegeddon
//
//  Created by Pedro Carrasco on 10/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import ARKit

enum NodeType: String {
    case bug = "bug"
    case sight = "sight"
    case firebug = "firebug"
    case bugspray = "bugspray"
}

extension NodeType {
    func asSprite() -> SKSpriteNode{
        return SKSpriteNode(imageNamed: self.rawValue)
    }
}
