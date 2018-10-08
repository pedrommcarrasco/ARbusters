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
    @IBOutlet private weak var recordStackView: UIStackView!
    @IBOutlet private weak var recordLabel: CountingLabel!
    @IBOutlet private weak var noRecordsLabel: UILabel!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var popupView: UIView!
    @IBOutlet private weak var visualEffectView: UIVisualEffectView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var timeUnitLabel: UILabel!

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
        titleLabel.text = StringKey.Home.highestScore.localizedUppercaseString
        backButton.setTitle(StringKey.General.back.localizedUppercaseString, for: .normal)
        noRecordsLabel.text = StringKey.Records.none.localizedString
        timeUnitLabel.text = StringKey.General.seconds.localizedString

        backButton.standardRoundedCorners()
        popupView.smallRoundedCorners()

        let highestScore = UserDefaults.standard.integer(forKey: Constants.highestScoreKey)
        if highestScore != Constants.emptyScore {
            recordLabel.count(til: Float(highestScore), with: Constants.longerAnimationDuration)
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
        popupView.transform = CGAffineTransform(scaleX: Constants.highScale,
                                                y: Constants.highScale)
        popupView.alpha = 0
        UIView.animate(withDuration: Constants.animationDuration) { [weak self] in
            self?.visualEffectView.effect = UIBlurEffect(style: .dark)
            self?.popupView.transform = CGAffineTransform.identity
            self?.popupView.alpha = 1
        }
    }

    private func animateExit() {
        UIView.animate(withDuration: Constants.animationDuration, animations: { [weak self] in
            self?.visualEffectView.effect = nil
            self?.popupView.transform = CGAffineTransform(scaleX: Constants.lowScale,
                                                          y: Constants.lowScale)
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
