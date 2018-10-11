//
//  Constrictable+ConstrictorCore.swift
//  Constrictor
//
//  Created by Pedro Carrasco on 26/05/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

extension Constrictable {
    
    /**
     Internal Constrictor's core method.
     Applies a constraint between two Constrictable items.
     
     - parameters:
     - selfAttribute: Self's item layout attribute
     - relation: Relation between both attributes
     - item: Constrictable's item to apply a constraint with.
     - attribute: Item's layout attribute to constraint with.
     - constant: Constraint's constant
     - multiplier: Constraint's multiplier
     - priority: Constraint's priority
     
     This method's responsible for abstracting and invoking methods responsible of converting ConstrictorAttribute to
     NSLayoutConstraint.Attribute and normalizing the constant based on the selfAttribute
     */
    
    func constrict(_ selfAttribute: ConstrictorAttribute,
                   relation: NSLayoutConstraint.Relation = .equal,
                   to item: Constrictable,
                   attribute: ConstrictorAttribute,
                   constant: Constant,
                   multiplier: CGFloat = 1.0,
                   priority: UILayoutPriority = .required) {

        prepareForAutoLayout()

        let items = LayoutItemFactory.makeLayoutItems(firstElement: self,
                                                      secondElement: item,
                                                      firstAttribute: selfAttribute,
                                                      secondAttribute: attribute,
                                                      constant: constant)

        NSLayoutConstraint(item: self,
                           attribute: items.head.attribute,
                           relatedBy: relation,
                           toItem: items.tail.element,
                           attribute: items.tail.attribute,
                           multiplier: multiplier,
                           constant: items.head.constant).isActive = true
    }
    
    /**
     Internal Constrictor's core method.
     Applies a constraint to itself.
     
     - parameters:
     - selfAttribute: Self's item layout attribute
     - relation: Relation between constraint and constant
     - constant: Constraint's constant
     - multiplier: Constraint's multiplier
     - priority: Constraint's priority
     
     This method's responsible for abstracting and invoking methods responsible of converting ConstrictorAttribute to
     NSLayoutConstraint.Attribute and normalizing the constant based on the selfAttribute
     */
    
    func constrict(_ selfAttribute: ConstrictorAttribute,
                   relation: NSLayoutConstraint.Relation = .equal,
                   constant: Constant,
                   multiplier: CGFloat = 1.0,
                   priority: UILayoutPriority = .required) {

        prepareForAutoLayout()
        
        let item = LayoutItemFactory.makeLayoutItem(element: self,
                                                    attribute: selfAttribute,
                                                    constant: constant)
        
        NSLayoutConstraint(item: self,
                           attribute: item.attribute,
                           relatedBy: relation,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: multiplier,
                           constant: item.constant).isActive = true
    }
}

// MARK; - Utils
private extension Constrictable {

    func prepareForAutoLayout() {

        if let constrictableAsView = self as? UIView {

            constrictableAsView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
