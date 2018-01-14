//
//  VictoryView.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 13/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

class VictoryView: UIView {

    // MARK: - OUTLETS
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var highestScoreLabel: UILabel!
    @IBOutlet weak var timeUnitLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }

    // MARK: - SETUP
    func setup(with time: Int) {
        timeLabel.text = String(time)
        titleLabel.text = "won-title".localizedUppercaseString
        highestScoreLabel.text = "won-newHighestScore".localizedUppercaseString
        timeUnitLabel.text = "general-seconds".localizedUppercaseString

        if Utils.isNewRecord(timeTook: time) {
            newHighestScoreEntrance()
        }
    }

    private func newHighestScoreEntrance() {
        highestScoreLabel.transform = CGAffineTransform(scaleX: Constants.lowScale,
                                                        y: Constants.lowScale)

        UIView.animate(withDuration: Constants.animationDuration, delay: 1, options: [],
                       animations: {
                        [weak self] in
                        self?.highestScoreLabel.transform = CGAffineTransform.identity
                        self?.highestScoreLabel.alpha = 1
        }, completion: nil)
    }
}
