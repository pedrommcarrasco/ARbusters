//
//  MusicState.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 11/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import Foundation

// MARK: - MusicAction
enum MusicAction {
    case start
    case stop
}

// MARK: - MusicAction
enum MusicVolumeAction {
    case mute
    case unmute
}

extension MusicVolumeAction {

    func invert() -> MusicVolumeAction {

        if self == .mute { return .unmute
        } else { return .mute }
    }
}
