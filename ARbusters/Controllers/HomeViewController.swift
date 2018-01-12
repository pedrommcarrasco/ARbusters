//
//  HomeViewController.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 11/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - OUTLETS
    @IBOutlet weak var playButton: UIButton!

    // MARK: - LIFECICLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
    }

    // MARK: - SETUP
    private func setupButtons() {
        playButton.standartRoundedCorners()
    }
}
