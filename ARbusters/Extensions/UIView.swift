//
//  UIView.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 14/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

extension UIView: Roundable {
    func loadNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName:  String(describing: type(of: self)), bundle: bundle)

        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView

        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        addSubview(view)
    }
}
