//
//  Identifiable.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 14/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

protocol Identifiable {}

extension Identifiable {
    static var name: String { return String(describing: self) }
}
