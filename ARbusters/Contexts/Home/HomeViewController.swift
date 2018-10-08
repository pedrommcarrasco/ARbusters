//
//  HomeViewController.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 11/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

// MARK: - HomeViewController
class HomeViewController: UIViewController {
    
    // MARK: Constants
    private enum Constant {
        static let howToPlayMultiplier = 1.0
        static let playButtonMultipler = 2.0
        static let highestScoreMultiplier = 3.0
    }

    // MARK: Outlets
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var highestScoreButton: UIButton!
    @IBOutlet private weak var howToPlayImageView: UIImageView!

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        howToPlayImageView.animate(from: .top, delayMultiplier: Constant.howToPlayMultiplier)
        playButton.animate(from: .bottom, delayMultiplier: Constant.playButtonMultipler)
        highestScoreButton.animate(from: .bottom, delayMultiplier: Constant.highestScoreMultiplier)
    }
}

// MARK: - Configuration
private extension HomeViewController {
    
    func configure() {
        playButton.setTitle(StringKey.Home.play.localizedUppercaseString, for: .normal)
        highestScoreButton.setTitle(StringKey.Home.highestScore.localizedUppercaseString, for: .normal)
        
        playButton.standardRoundedCorners()
        highestScoreButton.standardRoundedCorners()
    }
}

// MARK: - Actions
private extension HomeViewController {
    
    @IBAction func highestScoreBtnAction(_ sender: UIButton) {
        view.addSubview(ScoreView(frame: view.bounds))
    }
}
