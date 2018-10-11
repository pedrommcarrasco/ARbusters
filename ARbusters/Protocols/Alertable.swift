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

        let alert = UIAlertController(title: StringKey.Alert.title.localizedString,
                                      message: StringKey.Alert.description.localizedString,
                                      preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: StringKey.General.ok.localizedUppercaseString,
                                      style: .default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
}
