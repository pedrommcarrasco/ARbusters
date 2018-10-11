//
//  Image.swift
//  Dex
//
//  Created by Pedro Carrasco on 19/08/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

// MARK: - Image
enum Image {

    enum Design {
        static let defeat = UIImage(named: "design-defeat")
        static let logo = UIImage(named:"design-logo")
        static let rules = UIImage(named:"design-rules")
    }

    enum Icon {
        static let close = UIImage(named:"ic-close")

        enum Music {
            static let turnOn = UIImage(named:"ic-music-turnOn")
            static let turnOff = UIImage(named:"ic-music-turnOff")
        }
    }

    enum Node {
        static let sight = UIImage(named:"aim")
        static let antiBossBuff = UIImage(named:"antiBossBuff")
        static let boss = UIImage(named:"boss")
        static let ghost = UIImage(named:"ghost")
    }
}
