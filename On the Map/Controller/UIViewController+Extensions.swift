//
//  UIViewController+Extensions.swift
//  On the Map
//
//  Created by Marky Jordan on 12/14/20.
//

import Foundation
import UIKit

extension UIViewController {
    
    // hide the keyboard when users taps anywhere outside a textfield
    func dismissKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    // open links in Safari
    func openURL(_ url: String) {
        guard let url = URL(string: url), UIApplication.shared.canOpenURL(url) else {
            Alert.showInvalidURL(on: self)
            return
        }
        UIApplication.shared.open(url, options: [:])
    }
}
