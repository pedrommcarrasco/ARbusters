//
//  ScoreView.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 12/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

class ScoreView: UIView {

    // MARK: - OUTLETS
    @IBOutlet weak var recordStackView: UIStackView!
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var noRecordsLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var popupView: UIView!
    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
        setup()
    }

    // MARK: - SETUP
    func setup() {
        
        backButton.standartRoundedCorners()
        popupView.smallRoundedCorners()

        let highestScore = UserDefaults.standard.integer(forKey: "HighestScore")
        if highestScore != 0 {
            recordLabel.text = String(highestScore)
            recordStackView.isHidden = false
            noRecordsLabel.isHidden = true
        } else {
            noRecordsLabel.isHidden = false
            recordStackView.isHidden = true
        }
    }

    // MARK: - ACTIONS
    @IBAction func backBtnAction(_ sender: Any) {
        removeFromSuperview()
    }
}
