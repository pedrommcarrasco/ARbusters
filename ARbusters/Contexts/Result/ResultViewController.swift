//
//  ResultViewController.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 14/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

class ResultViewControlelr: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var resultViewContainer: UIView!

    // MARK: - PROPERTIES
    var victoryView: VictoryView?
    var defeatView: DefeatView?

    var didWin: Bool?
    var timeTook: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupResultView()
    }

    // MARK: - LIFECYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if didWin == true {
            victoryView?.frame = resultViewContainer.bounds
        } else {
            defeatView?.frame = resultViewContainer.bounds
        }
    }

    // MARK: - SETUP
    func setupResultView() {
        if didWin == true {
            didWinSetup()
        } else {
            defeatView = DefeatView(frame: .zero)
            guard let defeatView = self.defeatView else { return }
            resultViewContainer.addSubview(defeatView)
        }
    }

    private func didWinSetup() {
        victoryView = VictoryView(frame: .zero)
        guard let victoryView = self.victoryView else { return }
        victoryView.setup(with: timeTook)
        resultViewContainer.addSubview(victoryView)
    }

    // MARK: - ACTIONS
    @IBAction func okBtnAction(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
