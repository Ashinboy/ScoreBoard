//
//  AlertManager.swift
//  ScoreBoard
//
//  Created by Ashin Wang on 2024/10/26.
//

import Foundation
import UIKit


class AlertManager {
    static func showAlert(on viewController: UIViewController, title: String, message: String, complaetion: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Done", style: .default) { _ in
            complaetion?()
        }
        alert.addAction(okAction)
        viewController.present(alert, animated: true,completion: nil)
    }
}
