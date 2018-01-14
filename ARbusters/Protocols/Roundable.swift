//
//  Roundable.swift
//  ARniegeddon
//
//  Created by Pedro Carrasco on 11/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//


import UIKit

protocol Roundable { }

extension Roundable where Self: UIView {

    func standartRoundedCorners() {
        self.layer.cornerRadius = self.bounds.height/2
    }

    func smallRoundedCorners() {
        self.layer.cornerRadius = 9
    }
}
