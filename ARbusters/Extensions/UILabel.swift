//
//  UILabel.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 09/10/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

// MARK: - Setup
extension UILabel {

    func setup(with text: String, fontSize: CGFloat = Size.M, color: UIColor = .black) {

        font = UIFont(name: Font.regular, size: fontSize)
        textAlignment = .center
        textColor = color
        numberOfLines = 0
        self.text = text
    }
}

extension CountingLabel {

    func setup(fontSize: CGFloat = Size.M, color: UIColor = .black) {

        font = UIFont(name: Font.regular, size: fontSize)
        textAlignment = .center
        textColor = color
        numberOfLines = 0
        text = "0"
    }
}
