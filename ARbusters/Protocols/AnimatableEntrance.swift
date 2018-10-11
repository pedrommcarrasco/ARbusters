//
//  AnimatableEntrance.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 09/10/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

typealias AnimatableEntranceView = (UIView & AnimatableEntrance)

// MARK: - AnimatableEntrance
protocol AnimatableEntrance {

    // MARK:  Functions
    func animateEntrance()
}
