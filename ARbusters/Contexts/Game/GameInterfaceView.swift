//
//  GameInterfaceView.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 10/10/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit
import SpriteKit

// MARK: - GameInterfaceViewDelegate
protocol GameInterfaceViewDelegate: class {

    // MARK: Functions
    func didPressQuit(in view: GameInterfaceView)
    func didPressVolume(in view: GameInterfaceView)
}

// MARK: - GameInterfaceView
class GameInterfaceView: UIView {

    // MARK: Constant
    private enum Constant {

        enum Height {
            static let button: CGFloat = 64.0
            static let sight: CGFloat = 50.0
        }
    }

    // MARK: Outlets
    private let timeStackView: TimeStackView
    private let sightImageView: UIImageView = .create {
        $0.setup(with: Image.Node.sight)
    }
    private let quitButton: UIButton = .create {
        $0.setup(with: Image.Icon.close)
    }
    private let volumeButton: UIButton = .create {
        $0.setup(with: Image.Icon.Music.turnOff)
        $0.setup(with: Image.Icon.Music.turnOn, for: .selected)
        // TODO THIS AIN'T WORKING
    }

    // MARK: Properties
    weak var delegate: GameInterfaceViewDelegate?

    // MARK: Initializers
    init() {
        self.timeStackView = TimeStackView()

        super.init(frame: .zero)

        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()

        [volumeButton, quitButton].forEach { $0.standardRoundedCorners() }
    }
}

// MARK: - Configuration
private extension GameInterfaceView {

    func configure() {

        addSubviews()
        defineConstraints()
        setupViews()
    }

    func addSubviews() {
        addSubviews(sightImageView, timeStackView, quitButton, volumeButton)
    }

    func defineConstraints() {

        sightImageView
            .constrictCenterInParent()
            .constrictSize(to: Constant.Height.sight)

        timeStackView
            .constrictToParent(attributes: .centerX, .bottomGuide, with: .bottom(Spacing.S))

        quitButton
            .constrictSize(to: Constant.Height.button)
            .constrictToParent(attributes: .bottomGuide, .leading, with: .all(Spacing.S))

        volumeButton
            .constrictSize(to: Constant.Height.button)
            .constrictToParent(attributes: .bottomGuide, .trailing, with: .all(Spacing.S))
    }

    func setupViews() {

        timeStackView.timeLabel.setup(fontSize: Size.XXL, color: Color.pink)
        timeStackView.timeUnitLabel.setup(with: StringKey.General.seconds.localizedString, fontSize: Size.L)

        quitButton.addTarget(self, action: #selector(quitButtonAction), for: .touchUpInside)
        volumeButton.addTarget(self, action: #selector(volumeButtonAction), for: .touchUpInside)
    }
}

// MARK: - Public Functions
extension GameInterfaceView {

    func updateTime(with time: Int) {

        UIView.transition(with: timeStackView.timeLabel,
                          duration: Duration.S,
                          options: .transitionFlipFromTop,
                          animations: { self.timeStackView.timeLabel.text = "\(time)" },
                          completion: nil)
    }
}

// MARK: - Actions
private extension GameInterfaceView {

    @objc func quitButtonAction() {

        quitButton.touchAnimation()
        delegate?.didPressQuit(in: self)
    }

    @objc func volumeButtonAction() {

        volumeButton.touchAnimation()
        delegate?.didPressVolume(in: self)
    }
}
