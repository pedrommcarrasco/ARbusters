//
//  HomeViewController.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 11/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - OUTLETS
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var highestScoreButton: UIButton!
    @IBOutlet weak var howToPlayImageView: UIImageView!

    // MARK: - LIFECICLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        howToPlayImageView.animate(from: .top, and: 1)
        playButton.animate(from: .bottom, and: 2)
        highestScoreButton.animate(from: .bottom, and: 3)
    }

    // MARK: - SETUP
    private func setupButtons() {
        playButton.setTitle("home-play".localizedUppercaseString,
                            for: .normal)
        highestScoreButton.setTitle("home-highestScore".localizedUppercaseString,
                                    for: .normal)

        playButton.standartRoundedCorners()
        highestScoreButton.standartRoundedCorners()
    }

    // MARK: - ACTIONS
    @IBAction func highestScoreBtnAction(_ sender: UIButton) {
        view.addSubview(ScoreView(frame: view.bounds))
    }
}
