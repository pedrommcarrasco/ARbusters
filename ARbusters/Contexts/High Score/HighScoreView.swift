//
//  HighScoreView.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 09/10/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit
import Constrictor

// MARK: - HighScoreViewDelegate
protocol HighScoreViewDelegate: class {

    // MARK: Functions
    func didPressBack(in view: HighScoreView)
}

// MARK: - HighScoreView
class HighScoreView: UIView {

    // MARK: Constant
    private enum Constant {

    }

    // MARK: Outlets
    private let containerView: UIView = .create {
        $0.backgroundColor = Color.white
    }

    private let titleLabel: UILabel = .create {
        $0.setup(with: StringKey.Records.title.localizedUppercaseString, fontSize: Size.XL, color: Color.pink)
    }

    private let timeStackView: TimeStackView

    private let noDataLabel: UILabel = .create {
        $0.setup(with: StringKey.Records.none.localizedString, fontSize: Size.M)
    }

    private let backButton: UIButton = .create {
        $0.setup(with: StringKey.General.back.localizedUppercaseString, fontSize: Size.S)
    }

    // MARK: Properties
    weak var delegate: HighScoreViewDelegate?

    // MARK: Private properties
    private let highestScore: Int?
    private let didPlay: Bool

    // MARK: Initializers
    init(with highestScore: Int?, didPlay: Bool) {

        self.highestScore = highestScore
        self.didPlay = didPlay
        self.timeStackView = TimeStackView()

        super.init(frame: .zero)

        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()

        containerView.smallRoundedCorners()
        backButton.smallRoundedCorners()
    }
}

// MARK: - AnimatableEntrance
extension HighScoreView: AnimatableEntrance {

    func animateEntrance() {

        titleLabel.animate(from: .top, delayMultiplier: 1)

        if didPlay {
            timeStackView.animate(from: .top, delayMultiplier: 2)
            timeStackView.timeLabel.count(til: Float(highestScore ?? 0), with: Duration.L)
        } else {
            noDataLabel.animate(from: .top, delayMultiplier: 2)
        }

        backButton.animate(from: .top, delayMultiplier: 3)
    }
}

// MARK: - Configuration
private extension HighScoreView {

    func configure() {

        let selectedView = didPlay ? timeStackView : noDataLabel

        addSubviews(with: selectedView)
        defineConstraints(with: selectedView)
        setupViews()
    }

    func addSubviews(with selectedView: UIView) {

        addSubviews(containerView)
        containerView.addSubviews(titleLabel, backButton, selectedView)
    }

    func defineConstraints(with selectedView: UIView) {

        containerView
            .constrictToParent(attributes: .leading, .trailing, .centerY, with: .leading(Spacing.M) & .trailing(Spacing.M))

        titleLabel
            .constrictToParent(attributes: .top, .leading, .trailing, with: .all(Spacing.S))

        selectedView
            .constrict(.top, to: titleLabel, attribute: .bottom, with: Spacing.S)
            .constrictToParent(attributes: .leading, .trailing, with: .all(Spacing.S))
            .constrict(.bottom, to: backButton, attribute: .top, with: Spacing.S)

        backButton
            .constrictToParent(attributes: .bottom, .leading, .trailing, with: .all(Spacing.S))
    }

    func setupViews() {

        backgroundColor = Color.transparentBlack

        timeStackView.timeLabel.setup(fontSize: Size.XXXL)
        timeStackView.timeUnitLabel.setup(with: StringKey.General.seconds)

        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
    }

}

// MARK: - Actions
private extension HighScoreView {

    @objc func backButtonAction() {

        delegate?.didPressBack(in: self)
    }
}
