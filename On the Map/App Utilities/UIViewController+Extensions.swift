//
//  UIViewController+Extensions.swift
//  On the Map
//
//  Created by Marky Jordan on 12/14/20.
//

import Foundation
import UIKit

extension UIViewController {
    
    func dismissKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
