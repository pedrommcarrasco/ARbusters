//
//  UIView.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 14/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

extension UIView: Roundable {}

extension UIView: Animatable {}

extension UIView {

    func addSubviews(_ views: UIView ...) {
        views.forEach { self.addSubview($0) }
    }
}
