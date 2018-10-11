//
//  ResultView.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 09/10/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit
import Constrictor

// MARK: - ResultViewDelegate
protocol ResultViewDelegate: class {

    // MARK: Functions
    func didPressOk(in view: ResultView)
}

// MARK: - ResultView
class ResultView: UIView {
    typealias Static = ResultView

    // MARK: Constant
    private enum Constant {

        static let okMultiplier = 1.0

        enum Height {
            static let banner: CGFloat = 100.0
            static let ok: CGFloat = 64.0
        }
    }

    // MARK: Outlets
    private let bannerView: UIImageView = .create {
        $0.setup(with: Image.Design.logo)
    }

    private let okButton: UIButton = .create {
        $0.setup(with: StringKey.General.ok.localizedUppercaseString)
    }

    private let resultView: AnimatableEntranceView

    // MARK: Properties
    weak var delegate: ResultViewDelegate?

    // MARK: Initializers
    init(didWin: Bool, isNewRecord: Bool, time: Int?) {

        self.resultView = Static.view(didWin: didWin, isNewRecord: isNewRecord, time: time)

        super.init(frame: .zero)

        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()

        okButton.standardRoundedCorners()
    }
}

// MARK: - AnimatableEntrance
extension ResultView: AnimatableEntrance {

    func animateEntrance() {

        resultView.animateEntrance()
        okButton.animate(from: .bottom, delayMultiplier: Constant.okMultiplier)
    }
}

// MARK: - Configuration
private extension ResultView {

    func configure() {

        addSubviews()
        defineConstraints()
        setupViews()
    }

    func addSubviews() {
        addSubviews(bannerView, resultView, okButton)
    }

    func defineConstraints() {

        bannerView
            .constrictToParent(attributes: .topGuide, .leading, .trailing)
            .constrict(.height, with: Constant.Height.banner)

        resultView
            .constrictToParent(attributes: .leading, .trailing, with: .all(Spacing.S))
            .constrict(.top, to: bannerView, attribute: .bottom, with: Spacing.S)
            .constrict(.bottom, to: okButton, attribute: .top, with: Spacing.S)

        okButton
            .constrictToParent(attributes: .leading, .trailing, .bottomGuide, with: .all(Spacing.M))
            .constrict(.height, with: Constant.Height.ok)
    }

    func setupViews() {

        backgroundColor = Color.white

        okButton.addTarget(self, action: #selector(okButtonAction), for: .touchUpInside)
    }
}

// MARK: - Actions
private extension ResultView {

    @objc func okButtonAction() {
        delegate?.didPressOk(in: self)
    }
}

// MARK: - Utils
private extension ResultView {

    static func view(didWin: Bool, isNewRecord: Bool, time: Int?) -> AnimatableEntranceView {

        guard let time = time else { return DefeatView() }

        return didWin ? VictoryView(time: time, isNewRecord: isNewRecord) : DefeatView()
    }
}
