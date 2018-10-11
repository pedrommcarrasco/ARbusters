//
//  LayoutItem.swift
//  Constrictor
//
//  Created by Pedro Carrasco on 27/09/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import Foundation

// MARK: - HeadLayoutItem
struct HeadLayoutItem {

    let attribute: NSLayoutConstraint.Attribute
    let constant: CGFloat

    init(_ layoutItem: LayoutItem) {
        self.attribute = layoutItem.attribute
        self.constant = layoutItem.constant
    }
}

// MARK: - TailLayoutItem
struct TailLayoutItem {

    let element: Any?
    let attribute: NSLayoutConstraint.Attribute

    init(_ layoutItem: LayoutItem) {
        self.element = layoutItem.element
        self.attribute = layoutItem.attribute
    }
}

// MARK: - LayoutItem
struct LayoutItem {

    let element: Any?
    let attribute: NSLayoutConstraint.Attribute
    let constant: CGFloat

    var asHead: HeadLayoutItem {
        return HeadLayoutItem(self)
    }

    var asTail: TailLayoutItem {
        return TailLayoutItem(self)
    }

    init(element: Any? = nil, attribute: NSLayoutConstraint.Attribute = .notAnAttribute, constant: CGFloat = 0.0) {

        self.element = element
        self.attribute = attribute
        self.constant = constant
    }
}
