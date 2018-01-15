//
//  DefeatView.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 13/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

class DefeatView: UIView {

    // MARK: - OUTLETS
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var defeatImageView: UIImageView!

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
    private func setup() {
        titleLabel.text = "lost-title".localizedUppercaseString

        titleLabel.animate(from: .top, and: 1)
        defeatImageView.animate(from: .top, and: 2)
    }
}

