//
//  TimeStackView.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 11/10/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

// MARK:- TimeStackView
class TimeStackView: UIStackView {

    // MARK: Outlets
    let timeLabel = CountingLabel()
    let timeUnitLabel = UILabel()

    // MARK: Initializers
    init() {
        super.init(frame: .zero)

        configure()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Configuration
private extension TimeStackView {

    func configure() {

        addSubviews()
        setupViews()
    }

    func addSubviews() {

        addArrangedSubviews(timeLabel, timeUnitLabel)
    }

    func setupViews() {

        axis = .vertical
        alignment = .center
        distribution = .fill
        spacing = -Spacing.S
    }
}
