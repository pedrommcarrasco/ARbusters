//
//  NavigationController.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 12/08/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

// MARK: - NavigationController
final class NavigationController: UINavigationController {
    
    // MARK: Init
    init() {
        super.init(nibName: nil , bundle:nil)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configuration
private extension NavigationController {
    
    func configure() {
        navigationBar.isHidden = true
    }
}
