//
//  PersistenceProvider.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 09/10/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import Foundation

// MARK: - PersistenceProvidable
protocol PersistenceProvidable {

    // MARK: Properties
    var highestScore: Int { get }

    // MARK: Functions
    func isHighestScore(_ score: Int) -> Bool
}

// MARK: - PersistenceProvider
final class PersistenceProvider: PersistenceProvidable {

    // MARK: Constant
    private enum Constant {
        static let highestScoreKey = "ARbuster_highestScore"
    }

    // MARK: Properties
    var highestScore: Int {
        get { return userDefaults.integer(forKey: Constant.highestScoreKey) }
    }

    func isHighestScore(_ score: Int) -> Bool {

        if score > highestScore {
            userDefaults.set(score, forKey: Constant.highestScoreKey)
            return true
        }

        return false
    }

    // MARK: Private Properties
    private let userDefaults: UserDefaults

    // MARK: Initializer
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
}
