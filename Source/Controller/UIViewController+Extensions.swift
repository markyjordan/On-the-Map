//
//  UIViewController+Extensions.swift
//  On the Map
//
//  Created by Marky Jordan on 12/14/20.
//

import Foundation
import UIKit

extension UIViewController {
    
    //  change button tint to reflect its current state (enabled/disabled)
    func buttonEnabled(_ enabled: Bool, button: CustomButton) {
        if enabled {
            button.isEnabled = true
            button.alpha = 1.0
        } else {
            button.isEnabled = false
            button.alpha = 0.5
        }
    }

    //  hide the keyboard when users taps anywhere outside a textfield
    func dismissKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    //  open links in Safari
    func openURL(_ url: String) {
        guard let url = URL(string: url), UIApplication.shared.canOpenURL(url) else {
            Alert.showInvalidURL(on: self)
            return
        }
        UIApplication.shared.open(url, options: [:])
    }
}
