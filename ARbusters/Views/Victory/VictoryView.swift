//
//  VictoryView.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 13/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

// MARK:- VictoryView
class VictoryView: UIView {

    // MARK: Outlets
    @IBOutlet private weak var timeLabel: CountingLabel!
    @IBOutlet private weak var highestScoreLabel: UILabel!
    @IBOutlet private weak var timeUnitLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!

    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
}

// MARK: - Configuration
extension VictoryView {
    
    func configure(with time: Int) {
        titleLabel.text = StringKey.State.Victory.title.localizedUppercaseString
        highestScoreLabel.text = StringKey.State.Victory.newHighScore.localizedUppercaseString
        timeUnitLabel.text = StringKey.General.seconds.localizedString

        titleLabel.animate(from: .top, delayMultiplier: 1)
        timeLabel.animate(from: .top, delayMultiplier: 2)
        timeLabel.count(til: Float(time), with: Constants.longerAnimationDuration)
        timeUnitLabel.animate(from: .top, delayMultiplier: 3)

        if Utils.isNewRecord(timeTook: time) {
            highestScoreLabel.animate(from: .bottom, delayMultiplier: 4)
        }
    }
}

