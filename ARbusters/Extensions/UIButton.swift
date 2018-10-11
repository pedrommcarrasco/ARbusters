//
//  UIButton.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 11/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

// MARK: - Animation
extension UIButton {

    func touchAnimation() {
        self.transform = CGAffineTransform(scaleX: Scale.XS, y: Scale.XS)

        UIView.animate(withDuration: Duration.XL,
                       delay: 0,
                       usingSpringWithDamping: Damping.L,
                       initialSpringVelocity: Spring.XXL,
                       options: .allowUserInteraction,
                       animations: { self.transform = .identity },
                       completion: nil)
    }
}

// MARK: - Setup
extension UIButton {

    func setup(with title: String, fontSize: CGFloat) {
        setTitle(title, for: .normal)
        backgroundColor = Color.pink
        titleLabel?.font = UIFont(name: Font.regular, size: fontSize)
    }

    func setup(with image: UIImage?, for state: UIControl.State = .normal) {

        setImage(image, for: state)
    }
}
