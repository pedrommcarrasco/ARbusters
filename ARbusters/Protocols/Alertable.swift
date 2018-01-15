//
//  Alertable.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 15/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import UIKit

protocol Alertable {}

extension Alertable where Self: UIViewController {
    func presentAlert() {
        let alert = UIAlertController(title: "alert-title".localizedString,
                                      message: "alert-description".localizedString,
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "general-ok".localizedUppercaseString,
                                      style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
