//
//  String.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 14/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import Foundation

extension String {

    public var localizedString: String {
        return NSLocalizedString(self, comment: "")
    }

    public var localizedUppercaseString: String {
        return localizedString.uppercased()
    }
}
