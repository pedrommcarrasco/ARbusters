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
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
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
        setupUI()
        animateEntrance()

    }

    private func setupUI() {
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

    // MARK: - ANIMATIONS
    private func animateEntrance() {
        visualEffectView.effect = nil
        popupView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        popupView.alpha = 0
        UIView.animate(withDuration: 0.33) { [weak self] in
            self?.visualEffectView.effect = UIBlurEffect(style: .dark)
            self?.popupView.transform = CGAffineTransform.identity
            self?.popupView.alpha = 1
        }
    }

    private func animateExit() {
        UIView.animate(withDuration: 0.33, animations: { [weak self] in
            self?.visualEffectView.effect = nil
            self?.popupView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            self?.popupView.alpha = 0
        }) { [weak self] bool in
            self?.removeFromSuperview()
        }
    }

    // MARK: - ACTIONS
    @IBAction func backBtnAction(_ sender: Any) {
        animateExit()
    }
}
