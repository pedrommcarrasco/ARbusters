//
//  PersistenceDependency.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 09/10/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import Foundation

// MARK: - PersistenceDependency
protocol PersistenceDependency {
    var persistenceProvider: PersistenceProvidable { get }
}
