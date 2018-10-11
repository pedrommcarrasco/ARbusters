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

    func animate(from type: AnimationFromType, delayMultiplier: Double = 0.0) {
        let extra: CGFloat
        switch type {
        case .top:
            extra = -45.0
        case .bottom:
            extra = 45.0
        }

        self.center.y += extra
        self.alpha = 0
        UIView.animate(withDuration: Duration.M,
                       delay: 0.25 * delayMultiplier,
                       usingSpringWithDamping: Damping.M,
                       initialSpringVelocity: 0, options: .curveEaseOut,
                       animations: {
                        self.center.y += extra*(-1)
                        self.alpha = 1
        }, completion: nil)
    }
}
