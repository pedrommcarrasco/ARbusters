//
//  UILayoutPriority+Operators.swift
//  Constrictor
//
//  Created by Pedro Carrasco on 08/07/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import Foundation

extension UILayoutPriority {
    static func +(lhs: UILayoutPriority, rhs: Float) -> UILayoutPriority {
        return UILayoutPriority(lhs.rawValue + rhs)
    }
    
    static func -(lhs: UILayoutPriority, rhs: Float) -> UILayoutPriority {
        return UILayoutPriority(lhs.rawValue - rhs)
    }
}
