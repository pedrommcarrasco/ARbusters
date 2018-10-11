//
//  ConstrictorAttribute.swift
//  Constrictor
//
//  Created by Pedro Carrasco on 26/05/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import Foundation

// MARK: - ConstrictorAttribute
public enum ConstrictorAttribute {
    
    case top
    case topGuide
    
    case bottom
    case bottomGuide
    
    case right
    case rightGuide
    
    case left
    case leftGuide
    
    case leading
    case leadingGuide
    
    case trailing
    case trailingGuide
    
    case centerX
    case centerXGuide
    
    case centerY
    case centerYGuide
    
    case width
    case height
    
    case none
}

extension ConstrictorAttribute {

    // MARK: - Internal Static Properties
    static let guidedAttributes: [ConstrictorAttribute] = [.topGuide, .bottomGuide, .rightGuide, .leftGuide,
                                                           .leadingGuide, .trailingGuide, .centerXGuide, .centerYGuide]
}
