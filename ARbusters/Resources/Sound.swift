//
//  Sound.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 09/10/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import SpriteKit

enum Sound {
    static let shot = SKAction.playSoundFileNamed("shot", waitForCompletion: false)
    static let hit = SKAction.playSoundFileNamed("hit", waitForCompletion: false)
    static let buff = SKAction.playSoundFileNamed("buff", waitForCompletion: false)
}

enum Music {
    static let theme = "theme"
}

enum Extension {
    static let mp3 = "mp3"
}
