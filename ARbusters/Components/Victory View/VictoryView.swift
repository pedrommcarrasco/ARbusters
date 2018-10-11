//
//  VictoryView.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 13/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit
import Constrictor

// MARK:- VictoryView
class VictoryView: UIView {

    // MARK: Outlets
    private let titleLabel: UILabel = .create {
        $0.setup(with: StringKey.State.Victory.title.localizedUppercaseString, fontSize: Size.L, color: Color.pink)
    }

    private let timeStackView: TimeStackView
    private let highestScoreLabel: UILabel = .create {
        $0.setup(with: StringKey.State.Victory.newHighScore.localizedUppercaseString, color: Color.pink)
    }

    // MARK: Private Properties
    private let time: Int
    private let isNewRecord: Bool

    // MARK: Initializers
    init(time: Int, isNewRecord: Bool) {

        self.timeStackView = TimeStackView()
        self.time = time
        self.isNewRecord = isNewRecord

        super.init(frame: .zero)

        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - AnimatableEntrance
extension VictoryView: AnimatableEntrance {

    func animateEntrance() {

        titleLabel.animate(from: .top, delayMultiplier: 1)
        timeStackView.animate(from: .top, delayMultiplier: 2)
        timeStackView.timeLabel.count(til: Float(time), with: Duration.L)

        if isNewRecord {
            highestScoreLabel.animate(from: .bottom, delayMultiplier: 3)
        }
    }
}

// MARK: - Configuration
private extension VictoryView {

    func configure() {

        addSubviews()
        defineConstraints()
        setupViews()
    }

    func addSubviews() {

        addSubviews(titleLabel, timeStackView, highestScoreLabel)
    }

    func defineConstraints() {

        titleLabel
            .constrictToParent(attributes: .top, .leading, .trailing, with: .all(Spacing.S))

        timeStackView
            .constrict(.top, to: titleLabel, attribute: .bottom, with: Spacing.S)
            .constrict(to: titleLabel, attributes: .leading, .trailing)

        highestScoreLabel
            .constrict(.top, to: timeStackView, attribute: .bottom, with: Spacing.M)
            .constrict(to: titleLabel, attributes: .leading, .trailing)
            .constrictToParent(as: .lessThanOrEqual, attributes: .bottom)
    }

    func setupViews() {

        timeStackView.timeLabel.setup(fontSize: Size.XXXL)
        timeStackView.timeUnitLabel.setup(with: StringKey.General.seconds.localizedString)
    }
}
