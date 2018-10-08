//
//  Animatable.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 15/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

enum AnimationFromType {
    case top
    case bottom
}

protocol Animatable {
    func animate(from type: AnimationFromType, delayMultiplier: Double)
}

extension Animatable where Self: UIView {

    func animate(from type: AnimationFromType, delayMultiplier: Double) {
        let extra: CGFloat
        switch type {
        case .top:
            extra = -Constants.animationExtra
        case .bottom:
            extra = Constants.animationExtra
        }

        self.center.y += extra
        self.alpha = 0
        UIView.animate(withDuration: Constants.mediumAnimationDuration,
                       delay: Constants.standartDelay * delayMultiplier,
                       usingSpringWithDamping: Constants.standartDamping,
                       initialSpringVelocity: 0, options: .curveEaseOut,
                       animations: {
                        self.center.y += extra*(-1)
                        self.alpha = 1
        }, completion: nil)
    }
}
