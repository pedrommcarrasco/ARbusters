//
//  BackgroundMusicHandler.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 11/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import AVKit

class MusicManager {
    static let sharedInstance = MusicManager()
    private init() {}

    private var avPlayer: AVPlayer = AVPlayer(name: "theme", extension: "mp3")!
    private var musicState: MusicState = .playing

    func playBackgroundMusic() {
        avPlayer.playLoop()
    }

    func changeMusicState(clicked button: UIButton) {
        button.touchAnimation()

        switch musicState {
        case .playing:
            musicState = .muted
            avPlayer.volume = 0
            button.setImage(#imageLiteral(resourceName: "ic-music-turnOff"), for: .normal)
        case .muted:
            musicState = .playing
            avPlayer.volume = 0.05
            button.setImage(#imageLiteral(resourceName: "ic-music-turnOn"), for: .normal)
        }
    }
}
