//
//  HomeView.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 09/10/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit
import Constrictor

// MARK: - HomeViewDelegate
protocol HomeViewDelegate: class {

    // MARK: Functions
    func didPressPlay(in view: HomeView)
    func didPressHighestScore(in view: HomeView)
}

// MARK:- HomeView
class HomeView: UIView {

    // MARK: Constant
    // MARK: Constants
    private enum Constant {
        static let tutorialMultiplier = 1.0
        static let playButtonMultipler = 2.0
        static let highestScoreMultiplier = 3.0

        enum Height {
            static let banner: CGFloat = 200.0
            static let play: CGFloat = 64.0
            static let highscore: CGFloat = 32.0
        }
    }

    // MARK: Outlets
    private let bannerImageView: UIImageView = .create {
        $0.setup(with: Image.Design.logo)
    }

    private let playButton: UIButton = .create {
        $0.setup(with: StringKey.Home.play.localizedUppercaseString, fontSize: Size.M)
    }
    private let highestScoreButton: UIButton = .create {
        $0.setup(with: StringKey.Home.highestScore.localizedUppercaseString, fontSize: Size.S)
    }
    private let tutorialImageView: UIImageView = .create {
        $0.setup(with: Image.Design.rules)
    }

    // MARK: Properties
    weak var delegate: HomeViewDelegate?

    // MARK: Initializers
    init() {
        super.init(frame: .zero)

        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()

        [playButton, highestScoreButton].forEach { $0.standardRoundedCorners() }
    }
}

// MARK: - AnimatableEntrance
extension HomeView: AnimatableEntrance {

    func animateEntrance() {

        tutorialImageView.animate(from: .top, delayMultiplier: Constant.tutorialMultiplier)
        playButton.animate(from: .bottom, delayMultiplier: Constant.playButtonMultipler)
        highestScoreButton.animate(from: .bottom, delayMultiplier: Constant.highestScoreMultiplier)
    }
}

// MARK: - Configuration
private extension HomeView {

    func configure() {

        addSubviews()
        defineConstraints()
        setupViews()
    }

    func addSubviews() {
        addSubviews(bannerImageView, tutorialImageView, playButton, highestScoreButton)
    }

    func defineConstraints() {

        bannerImageView
            .constrictToParent(attributes: .topGuide, .leading, .trailing)
            .constrict(.height, with: Constant.Height.banner)

        tutorialImageView
            .constrict(to: playButton, attributes: .leading, .trailing)
            .constrict(.top, to: bannerImageView, attribute: .bottom)
            .constrict(.bottom, to: playButton, attribute: .top, with: Spacing.M)

        playButton
            .constrictToParent(attributes: .leading, .trailing, with: .all(Spacing.M))
            .constrict(.bottom, to: highestScoreButton, attribute: .top, with: Spacing.S)
            .constrict(.height, with: Constant.Height.play)

        highestScoreButton
            .constrictToParent(attributes: .centerX, .bottomGuide, with: .bottom(Spacing.S))
            .constrictToParent(attributes: .leading, .trailing, with: .all(Spacing.L))
            .constrict(.height, with: Constant.Height.highscore)
    }

    func setupViews() {

        backgroundColor = Color.white
        playButton.addTarget(self, action: #selector(playButtonAction), for: .touchUpInside)
        highestScoreButton.addTarget(self, action: #selector(highestScoreButtonAction), for: .touchUpInside)
    }

}

// MARK: - Actions
private extension HomeView {

    @objc func playButtonAction() {
        delegate?.didPressPlay(in: self)
    }

    @objc func highestScoreButtonAction() {
        delegate?.didPressHighestScore(in: self)
    }
}

