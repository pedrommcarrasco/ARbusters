//
//  NSObject.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 09/10/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import Foundation

// MARK: - Create
extension NSObject {

    static func create<T>(_ setup: ((T) -> Void)) -> T where T: NSObject {

        let obj = T()
        setup(obj)
        return obj
    }
}
