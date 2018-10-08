//
//  DefeatView.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 13/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

// MARK: - DefeatView
class DefeatView: UIView {
    
    // MARK: Constant
    private enum Constant {
        static let titleMultiplier = 1.0
        static let defeatMultiplier = 2.0
    }

    // MARK: Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var defeatImageView: UIImageView!

    // MARK: Initilizers
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
        configure()
    }
}

// MARK: - Configuration
private extension DefeatView {
    
    func configure() {
        titleLabel.text = StringKey.State.Defeat.title.localizedUppercaseString
        
        titleLabel.animate(from: .top, delayMultiplier: Constant.titleMultiplier)
        defeatImageView.animate(from: .top, delayMultiplier: Constant.defeatMultiplier)
    }
}

