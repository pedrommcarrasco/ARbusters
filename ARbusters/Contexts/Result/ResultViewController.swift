//
//  ResultViewController.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 14/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var resultViewContainer: UIView!
    @IBOutlet weak var okButton: UIButton!
    
    // MARK: - PROPERTIES
    var victoryView: VictoryView?
    var defeatView: DefeatView?

    var didWin: Bool?
    var timeTook: Int = 0

    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        okButton.animate(from: .bottom, delayMultiplier: 1)
        if didWin == true {
            victoryView?.frame = resultViewContainer.bounds
        } else {
            defeatView?.frame = resultViewContainer.bounds
        }
    }

    // MARK: - SETUP
    private func setup() {
        okButton.standartRoundedCorners()
        okButton.setTitle(StringKey.General.ok.localizedUppercaseString, for: .normal)
        setupResultView()
    }

    func setupResultView() {
        if didWin == true {
            didWinSetup()
        } else {
            didLoseSetup()
        }
    }

    private func didWinSetup() {
        victoryView = VictoryView(frame: .zero)
        guard let victoryView = self.victoryView else { return }
        victoryView.setup(with: timeTook)
        resultViewContainer.addSubview(victoryView)
    }

    private func didLoseSetup() {
        defeatView = DefeatView(frame: .zero)
        guard let defeatView = self.defeatView else { return }
        resultViewContainer.addSubview(defeatView)
    }

    // MARK: - ACTIONS
    @IBAction func okBtnAction(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
