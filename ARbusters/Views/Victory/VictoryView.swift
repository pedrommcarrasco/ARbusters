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

        if Utils.isNewRecord(timeTook: time) {
            highestScoreLabel.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            UIView.animate(withDuration: 0.33) { [weak self] in
                self?.highestScoreLabel.transform = CGAffineTransform.identity
                self?.highestScoreLabel.alpha = 1
            }
        }
    }
}
