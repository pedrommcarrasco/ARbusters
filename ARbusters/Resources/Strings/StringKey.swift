//
//  StringKey.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 08/10/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import Foundation

enum StringKey {
    
    enum Home {
        static let play = "home-play"
        static let highestScore = "home-highestScore"
    }
    
    enum General {
        static let seconds = "general-seconds"
        static let back = "general-back"
        static let ok = "general-ok"
    }
    
    enum Alert {
        static let title = "alert-title"
        static let description = "alert-description"
    }
    
    enum State {
        
        enum Victory {
            static let title = "won-title"
            static let newHighScore =  "won-newHighestScore"
        }
        
        enum Defeat {
            static let title = "lost-title"
        }
    }
    
    enum Records {
        static let none = "highestRecord-noRecords"
    }
}
