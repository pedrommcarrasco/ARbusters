//
//  MusicProvider.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 09/10/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//


import AVKit

// MARK: - MusicProvidable
protocol MusicProvidable {
    func apply(_ action: MusicAction)
    func apply(_ volumeAction: MusicVolumeAction)
}

// MARK: - MusicProvider
final class MusicProvider {

    // MARK: Constant
    private enum Constant {
        static let volume: Float = 0.1
    }

    // MARK: Properties
    private var player: AVPlayer

    // MARK: Initializer
    init() {

        player = AVPlayer()
    }
}

extension MusicProvider {

    func apply(_ action: MusicAction) {

        switch action {

        case .start: start()
        case .stop: stop()
        }
    }

    func apply(_ volumeAction: MusicVolumeAction) {

        switch volumeAction {

        case .mute: mute()
        case .unmute: unmute()
        }
    }
}

private extension MusicProvider {

    func start() {
        guard let backgroundPlayer = AVPlayer(name: Music.theme, extension: Extension.mp3) else { return }

        player = backgroundPlayer

        player.volume = Constant.volume
        player.playLoop()
    }

    func stop() {
        player.volume = 0
        player.endLoop()
    }

    func mute() {
        player.volume = 0
    }

    func unmute() {
        player.volume = Constant.volume
    }
}
