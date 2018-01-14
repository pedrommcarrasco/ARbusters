//
//  SoundType.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 10/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import SpriteKit

enum Sounds {
    static let shot = SKAction.playSoundFileNamed("shot", waitForCompletion: false)
    static let hit = SKAction.playSoundFileNamed("hit", waitForCompletion: false)
    static let buff = SKAction.playSoundFileNamed("buff", waitForCompletion: false)
    static let theme = "theme"
}
