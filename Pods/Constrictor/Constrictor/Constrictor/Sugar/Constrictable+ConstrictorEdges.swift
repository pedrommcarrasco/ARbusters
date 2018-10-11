//
//  Constrictable+ConstrictorEdges.swift
//  Constrictor
//
//  Created by Pedro Carrasco on 21/05/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

// MARK: - ConstrictorEdges
public extension Constrictable {
    
    /**
     Constricts self's edges to another Constrictable.
     
     - parameters:
     - relation: Relation between edges
     - item: Constrictable's item to constrict edges with.
     - constant: Constraints's constant
     - multiplier: Constraints's multiplier
     - priority: Constraints's priority
     - withinGuides: Bool indicating where to constraint to safeAreas/top and bottom layout guides or not.

     - returns:
     Discardable UIView to allow function's chaining.
     */
    
    @discardableResult
    func constrictEdges(as relation: NSLayoutConstraint.Relation = .equal,
                        to item: Constrictable,
                        with constant: Constant = .zero,
                        multiplyBy multiplier: CGFloat = 1.0,
                        prioritizeAs priority: UILayoutPriority = .required,
                        withinGuides: Bool = true) -> Self {
        
        if withinGuides {
            constrict(as: relation, to: item,
                      attributes: .topGuide, .bottomGuide, .leadingGuide, .trailingGuide,
                      with: constant, multiplyBy: multiplier, prioritizeAs: priority)
        } else {
            constrict(as: relation, to: item,
                      attributes: .top, .bottom, .leading, .trailing,
                      with: constant, multiplyBy: multiplier, prioritizeAs: priority)
        }
        
        return self
    }
}

// MARK: - ConstrictorEdges (UIView)
public extension Constrictable where Self: UIView {

    /**
     Constricts self's edges to its superview.

     - parameters:
     - relation: Relation between edges
     - constant: Constraints's constant
     - multiplier: Constraints's multiplier
     - priority: Constraints's priority
     - withinGuides: Bool indicating where to constraint to safeAreas/top and bottom layout guides or not.

     - returns:
     Discardable UIView to allow function's chaining.
     */

    @discardableResult
    func constrictEdgesToParent(as relation: NSLayoutConstraint.Relation = .equal,
                                with constant: Constant = .zero,
                                multiplyBy multiplier: CGFloat = 1.0,
                                prioritizeAs priority: UILayoutPriority = .required,
                                withinGuides: Bool = true) -> Self {

        guard let superview = superview else { return self }

        constrictEdges(as: relation, to: superview, with: constant,
                       multiplyBy: multiplier, prioritizeAs: priority, withinGuides: withinGuides)

        return self
    }
}
