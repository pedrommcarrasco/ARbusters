//
//  LayoutItemFactory.swift
//  Constrictor
//
//  Created by Pedro Carrasco on 28/09/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import Foundation

// MARK: - LayoutItemFactory
struct LayoutItemFactory {

    /**
     Converts a set of attributes, elements and constant into two LayoutItems

     - parameters:
     - firstElement: Optional Constrictable's to extract NSLayoutConstraint.Attribute from.
     - secondElement: Optional Constrictable's to extract NSLayoutConstraint.Attribute from.
     - firstAttribute: ConstrictorAttributor from the first element.
     - secondAttribute: ConstrictorAttributor from the second element.
     - constant: Constant to be applied to the first element.

     - returns:
     Tuple containing an HeadLayoutImte & TailLayoutItem (starting anchor and ending anchor).
     */
    static func makeLayoutItems(firstElement: Constrictable?, secondElement: Constrictable?,
                                firstAttribute: ConstrictorAttribute, secondAttribute: ConstrictorAttribute,
                                constant: Constant) -> (head: HeadLayoutItem, tail: TailLayoutItem) {

        let firstItem = layoutItem(for: firstElement, attribute: firstAttribute, constant: constant)
        let secondItem = layoutItem(for: secondElement, attribute: secondAttribute, constant: constant)

        return (firstItem.asHead, secondItem.asTail)
    }

    /**
     Converts an attribute, element and constant into a LayoutItem

     - parameters:
     - element: Optional Constrictable's to extract NSLayoutConstraint.Attribute from.
     - attribute: ConstrictorAttributor from the  element.
     - constant: Constant to be applied.

     - returns:
     HeadLayoutItem
     */

    static func makeLayoutItem(element: Constrictable?,
                               attribute: ConstrictorAttribute,
                               constant: Constant) -> HeadLayoutItem {

        return layoutItem(for: element, attribute: attribute, constant: constant).asHead
    }
}


// MARK: - Decision Maker
private extension LayoutItemFactory {


    static func layoutItem(for element: Constrictable?,
                           attribute: ConstrictorAttribute,
                           constant: Constant) -> LayoutItem {

        var item = LayoutItem()

        if let view = element as? UIView {
            item = layoutItem(view: view, with: attribute, and: constant)
        } else if let viewController = element as? UIViewController {
            item = layoutItem(viewController: viewController, with: attribute, and: constant)
        } else if let layoutGuide = element as? UILayoutGuide {
            item = layoutItem(layoutGuide: layoutGuide, with: attribute, and: constant)
        }

        return item
    }

    static func layoutItem(layoutGuide: UILayoutGuide,
                           with attribute: ConstrictorAttribute,
                           and constantStruct: Constant) -> LayoutItem {

        return buildLayoutItem(for: attribute, with: constantStruct, safeArea: layoutGuide)
    }

    static func layoutItem(view: UIView,
                           with attribute: ConstrictorAttribute,
                           and constantStruct: Constant) -> LayoutItem {

        let safeArea: Any

        if #available(iOS 11.0, *), ConstrictorAttribute.guidedAttributes.contains(attribute) {
            safeArea = view.safeAreaLayoutGuide
        } else {
            safeArea = view
        }

        return buildLayoutItem(for: attribute, with: constantStruct, safeArea: safeArea)
    }

    static func layoutItem(viewController: UIViewController,
                           with constrictorAttribute: ConstrictorAttribute,
                           and constantStruct: Constant) -> LayoutItem {

        let safeArea: Any
        let atLeastiOS11: Bool

        if #available(iOS 11.0, *), ConstrictorAttribute.guidedAttributes.contains(constrictorAttribute) {
            safeArea = viewController.view.safeAreaLayoutGuide
            atLeastiOS11 = true
        } else {
            safeArea = viewController.view
            atLeastiOS11 = false
        }

        return buildLayoutItem(for: constrictorAttribute,
                               with: constantStruct,
                               viewController: viewController,
                               atLeastiOS11: atLeastiOS11,
                               safeArea: safeArea)
    }
}

// MARK: - Builder
private extension LayoutItemFactory {

    static func buildLayoutItem(for constrictorAttribute: ConstrictorAttribute,
                                with constantStruct: Constant,
                                viewController: UIViewController? = nil,
                                atLeastiOS11: Bool? = nil,
                                safeArea: Any) -> LayoutItem {

        let attribute: NSLayoutConstraint.Attribute
        let constant: CGFloat
        var element = safeArea

        switch constrictorAttribute {
        case .top:
            attribute = .top
            constant = constantStruct.top

        case .topGuide:
            attribute = .top
            constant = constantStruct.top

            if let atLeastiOS11 = atLeastiOS11, !atLeastiOS11, let vc = viewController { element = vc.topLayoutGuide
            } else { element = safeArea }

        case .bottom:
            attribute = .bottom
            constant = -constantStruct.bottom

        case .bottomGuide:
            attribute = .bottom
            constant = -constantStruct.bottom

            if let atLeastiOS11 = atLeastiOS11, !atLeastiOS11, let vc = viewController { element = vc.bottomLayoutGuide
            } else { element = safeArea }

        case .right, .rightGuide:
            attribute = .right
            constant = -constantStruct.right

        case .left, .leftGuide:
            attribute = .left
            constant = constantStruct.left

        case .leading, .leadingGuide:
            attribute = .leading
            constant = constantStruct.leading

        case .trailing, .trailingGuide:
            attribute = .trailing
            constant = -constantStruct.trailing

        case .centerX:
            attribute = .centerX
            constant = constantStruct.x

        case .centerXGuide:
            attribute = .centerX
            constant = constantStruct.x

            if let atLeastiOS11 = atLeastiOS11, !atLeastiOS11, let vc = viewController {
                element = safeLayoutGuide(for: vc)
            } else { element = safeArea }

        case .centerY:
            attribute = .centerY
            constant = constantStruct.y

        case .centerYGuide:
            attribute = .centerY
            constant = constantStruct.y

            if let atLeastiOS11 = atLeastiOS11, !atLeastiOS11, let vc = viewController {
                element = safeLayoutGuide(for: vc)
            } else { element = safeArea }

        case .width:
            attribute = .width
            constant = constantStruct.width

        case .height:
            attribute = .height
            constant = constantStruct.height

        case .none:
            attribute = .notAnAttribute
            constant = 0.0
        }

        return LayoutItem(element: element, attribute: attribute, constant: constant)
    }
}

// MARK: - Utils
private extension LayoutItemFactory {

    /**
     Get an UILayoutGuide pinned to the viewController's safe edges. 

     - parameters:
     - viewController: UIViewController to get an UILayoutGuide pinned its edges

     - returns:
     Safe UILayoutGuide.
     */

    static func safeLayoutGuide(for viewController: UIViewController) -> UILayoutGuide {

        let layoutGuide = UILayoutGuide()
        viewController.view.addLayoutGuide(layoutGuide)

        NSLayoutConstraint.activate(
            [
                NSLayoutConstraint(
                    item: layoutGuide, attribute: .top, relatedBy: .equal,
                    toItem: viewController.topLayoutGuide, attribute: .bottom,
                    multiplier: 1, constant: 0
                ),
                NSLayoutConstraint(
                    item: layoutGuide, attribute: .bottom, relatedBy: .equal,
                    toItem: viewController.bottomLayoutGuide, attribute: .top,
                    multiplier: 1, constant: 0
                ),
                NSLayoutConstraint(
                    item: layoutGuide, attribute: .leading, relatedBy: .equal,
                    toItem: viewController.view, attribute: .leading,
                    multiplier: 1, constant: 0
                ),
                NSLayoutConstraint(
                    item: layoutGuide, attribute: .trailing, relatedBy: .equal,
                    toItem: viewController.view, attribute: .trailing,
                    multiplier: 1, constant: 0
                )
            ]
        )

        return layoutGuide
    }
}
