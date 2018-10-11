//
//  Constrictable+ConstrictorSize.swift
//  Constrictor
//
//  Created by Pedro Carrasco on 28/09/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

// MARK: - ConstrictSize
public extension Constrictable {

    /**
     Constricts self's size to another Constrictable.

     - parameters:
     - relation: Relation between center
     - item: Constrictable's item to match dimensions.
     - constant: Constraints' constant
     - multiplier: Constraints' multiplier
     - priority: Constraints' priority

     - returns:
     Discardable UIView to allow function's chaining.
     */

    @discardableResult
    func constrictSize(as relation: NSLayoutConstraint.Relation = .equal,
                       to item: Constrictable,
                       with constant: Constant = .zero,
                       multiplyBy multiplier: CGFloat = 1.0,
                       prioritizeAs priority: UILayoutPriority = .required) -> Self {

        constrict(as: relation, to: item, attributes: .width, .height,
                  with: constant, multiplyBy: multiplier, prioritizeAs: priority)

        return self
    }


    /**
     Constricts self's size based in a constant. Allows you to specify different constants to height and width

     - parameters:
     - relation: Relation between center
     - constant: Constraints' constant
     - priority: Constraints' priority

     - returns:
     Discardable UIView to allow function's chaining.
     */

    @discardableResult
    func constrictSize(as relation: NSLayoutConstraint.Relation = .equal,
                       to constant: Constant,
                       prioritizeAs priority: UILayoutPriority = .required) -> Self {


        constrict(as: relation, attributes: .width, .height,
                  with: constant, prioritizeAs: priority)

        return self
    }

    /**
     Constricts self's size based in a constant. Same width & height.

     - parameters:
     - relation: Relation between center
     - constant: Constraints' constant
     - priority: Constraints' priority

     - returns:
     Discardable UIView to allow function's chaining.
     */

    @discardableResult
    func constrictSize(as relation: NSLayoutConstraint.Relation = .equal,
                       to constant: CGFloat,
                       prioritizeAs priority: UILayoutPriority = .required) -> Self {


        constrictSize(as: relation, to: Constant(size: constant), prioritizeAs: priority)

        return self
    }
}

// MARK: - ConstrictorCenter (UIView)
public extension Constrictable where Self: UIView {

    /**
     Constricts self's size to its superview.

     - parameters:
     - relation: Relation between center
     - constant: Constraints' constant
     - multiplier: Constraints' multiplier
     - priority: Constraints' priority

     - returns:
     Discardable UIView to allow function's chaining.
     */

    @discardableResult
    func constrictSizeToParent(as relation: NSLayoutConstraint.Relation = .equal,
                               with constant: Constant = .zero,
                               multiplyBy multiplier: CGFloat = 1.0,
                               prioritizeAs priority: UILayoutPriority = .required) -> Self {

        guard let superview = superview else { return self }

        constrictSize(as: relation, to: superview,
                      with: constant, multiplyBy: multiplier, prioritizeAs: priority)

        return self
    }
}
