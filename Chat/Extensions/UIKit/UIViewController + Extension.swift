//
//  UIViewController + Extension.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 21.03.2022.
//

import UIKit

extension UIViewController {
    func showAlert(title: String?, message: String?, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in 
            completion?()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showError(error: Error) {
        showAlert(title: "Error!", message: error.localizedDescription)
    }
}
