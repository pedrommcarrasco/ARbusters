//
//  Utils.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 14/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import Foundation

struct Utils {
    static func isNewRecord(timeTook: Int) -> Bool {
        let highestScore = UserDefaults.standard.integer(forKey: Constants.highestScoreKey)
        if highestScore == 0 || highestScore > timeTook {
            UserDefaults.standard.set(timeTook, forKey: Constants.highestScoreKey)
            return true
        }
        return false
    }
}
