//
//  UIImageView.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 09/10/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

// MARK: - Setup
extension UIImageView {

    func setup(with image: UIImage?) {
        self.image = image
        contentMode = .scaleAspectFit
    }
}

