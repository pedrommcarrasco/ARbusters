//
//  DefeatView.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 13/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

// MARK:- DefeatView
class DefeatView: UIView {

    // MARK: Constant
    private enum Constant {
        static let titleMultiplier = 1.0
        static let guideMultiplier = 2.0
    }

    // MARK: Outlets
    private let titleLabel: UILabel = .create {
        $0.setup(with: StringKey.State.Defeat.title.localizedUppercaseString, fontSize: Size.L, color: Color.pink)
    }

    private let guideImageView: UIImageView = .create {
        $0.setup(with: Image.Design.defeat)
    }

    // MARK: Initializers
    init() {

        super.init(frame: .zero)

        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - AnimatableEntrance
extension DefeatView: AnimatableEntrance {

    func animateEntrance() {

        titleLabel.animate(from: .top, delayMultiplier: Constant.titleMultiplier)
        guideImageView.animate(from: .top, delayMultiplier: Constant.guideMultiplier)
    }
}

// MARK: - Configuration
private extension DefeatView {

    func configure() {

        addSubviews()
        defineConstraints()
    }

    func addSubviews() {

        addSubviews(titleLabel, guideImageView)
    }

    func defineConstraints() {

        titleLabel
            .constrictToParent(attributes: .top, .leading, .trailing, with: .all(Spacing.S))

        guideImageView
            .constrict(.top, to: titleLabel, attribute: .bottom)
            .constrictToParent(attributes: .leading, .trailing)
            .constrictToParent(as: .lessThanOrEqual, attributes: .bottom)
            .constrict(.height, with: 100.0)
    }
}
