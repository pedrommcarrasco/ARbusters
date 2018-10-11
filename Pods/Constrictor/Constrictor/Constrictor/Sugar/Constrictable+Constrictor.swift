//
//  Constrictable+Constrictor.swift
//  Constrictor
//
//  Created by Pedro Carrasco on 21/05/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

// MARK: - Constrictor
public extension Constrictable {

    /**
     Applies multiple constraints between two Constrictable items.
     
     - parameters:
     - relation: Relation between constraint and constant.
     - item: Constrictable's item to apply a constraint with.
     - attributes: Item's layout attributes to constraint with.
     - constant: Constraint's constant.
     - multiplier: Constraint's multiplier.
     - priority: Constraint's priority.
     
     - returns:
     Discardable UIView to allow function's chaining.
     */
    
    @discardableResult
    func constrict(as relation: NSLayoutConstraint.Relation = .equal,
                   to item: Constrictable? = nil,
                   attributes: ConstrictorAttribute ...,
                   with constant: Constant = .zero,
                   multiplyBy multiplier: CGFloat = 1.0,
                   prioritizeAs priority: UILayoutPriority = .required) -> Self {
        
        attributes.forEach {
            if let item = item {
                constrict($0, relation: relation, to: item, attribute: $0,
                          constant: constant, multiplier: multiplier, priority: priority)
            } else {
                constrict($0, relation: relation, constant:
                    constant, multiplier: multiplier, priority: priority)
            }
        }
        
        return self
    }
    
    /**
     Applies a constraint between two Constrictable items.
     
     - parameters:
     - selfAttribute: Self's item layout attribute.
     - relation: Relation between constraint and constant.
     - item: Constrictable's item to apply a constraint with.
     - attribute: Item's layout attribute to constraint with.
     - constant: Constraint's constant.
     - multiplier: Constraint's multiplier.
     - priority: Constraint's priority.
     
     - returns:
     Discardable UIView to allow function's chaining.
     */
    
    @discardableResult
    func constrict(_ selfAttribute: ConstrictorAttribute,
                   as relation: NSLayoutConstraint.Relation = .equal,
                   to item: Constrictable? = nil,
                   attribute: ConstrictorAttribute = .none,
                   with constant: CGFloat = 0.0,
                   multiplyBy multiplier: CGFloat = 1.0,
                   prioritizeAs priority: UILayoutPriority = .required) -> Self {
        
        
        let constant = Constant(attribute: selfAttribute, value: constant)
        
        guard let item = item else {
            constrict(selfAttribute, relation: relation,
                      constant: constant, multiplier: multiplier, priority: priority)

            return self
        }
        
        constrict(selfAttribute, relation: relation, to: item, attribute: attribute,
                  constant: constant, multiplier: multiplier, priority: priority)
        
        return self
    }
}

// MARK: - Constrictor (UIView)
public extension Constrictable where Self: UIView {
    
    /**
     Applies multiple constraints between self and its superview.
     
     - parameters:
     - relation: Relation between constraint and constant.
     - item: Constrictable's item to apply a constraint with.
     - attributes: Item's layout attributes to constraint with.
     - constant: Constraint's constant.
     - multiplier: Constraint's multiplier.
     - priority: Constraint's priority.
     
     - returns:
     Discardable UIView to allow function's chaining.
     */
    
    @discardableResult
    func constrictToParent(as relation: NSLayoutConstraint.Relation = .equal,
                           attributes: ConstrictorAttribute ...,
                           with constant: Constant = .zero,
                           multiplyBy multiplier: CGFloat = 1.0,
                           prioritizeAs priority: UILayoutPriority = .required) -> Self {

        guard let parent = self.superview else { return self }
        
        attributes.forEach {
            constrict($0, relation: relation, to: parent, attribute: $0,
                      constant: constant, multiplier: multiplier, priority: priority)
        }
        
        return self
    }
}
