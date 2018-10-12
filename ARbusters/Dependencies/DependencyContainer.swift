//
//  DependencyContainer.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 09/10/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import Foundation

// MARK: - DependencyContainer
final class DependencyContainer: PersistenceDependency & MusicDependency {

    // MARK: Properties
    let persistenceProvider: PersistenceProvidable
    let musicProvider: MusicProvidable

    // MARK: Init
    init() {
        self.persistenceProvider = PersistenceProvider()
        self.musicProvider = MusicProvider()
    }
}
