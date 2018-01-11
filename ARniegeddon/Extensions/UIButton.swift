//
//  UIButton.swift
//  ARniegeddon
//
//  Created by Pedro Carrasco on 11/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

extension UIButton {
    func touchAnimation() {
        self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)

        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 6.0, options: .allowUserInteraction, animations: {
            self.transform = .identity
        }, completion: nil)
    }
}
