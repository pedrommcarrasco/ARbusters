//
//  ResultViewController.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 14/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

// MARK: - ResultViewController
class ResultViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet private weak var resultViewContainer: UIView!
    @IBOutlet private weak var okButton: UIButton!
    
    // MARK: Properties
    var victoryView: VictoryView?
    var defeatView: DefeatView?

    var didWin: Bool?
    var timeTook: Int = 0

    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
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
}

// MARK: - Configuration
private extension ResultViewController {
    
    func configure() {
        okButton.standardRoundedCorners()
        okButton.setTitle(StringKey.General.ok.localizedUppercaseString, for: .normal)
        configureResultView()
    }
    
    func configureResultView() {
        
        didWin == true ? configureDidWin() : configureDidLose()
    }
    
    func configureDidWin() {
        victoryView = VictoryView(frame: .zero)
        guard let victoryView = self.victoryView else { return }
        victoryView.configure(with: timeTook)
        resultViewContainer.addSubview(victoryView)
    }
    
    func configureDidLose() {
        defeatView = DefeatView(frame: .zero)
        guard let defeatView = self.defeatView else { return }
        resultViewContainer.addSubview(defeatView)
    }
}

// MARK: - Actions
private extension ResultViewController {
    
    @IBAction func okBtnAction(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
