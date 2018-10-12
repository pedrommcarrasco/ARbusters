//
//  MusicDependency.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 12/10/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import Foundation

// MARK: - MusicDependency
protocol MusicDependency {
    var musicProvider: MusicProvidable { get }
}
