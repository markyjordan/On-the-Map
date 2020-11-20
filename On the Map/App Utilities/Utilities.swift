//
//  Utilities.swift
//  On the Map
//
//  Created by Marky Jordan on 11/8/20.
//

import Foundation
import UIKit

class Utilities {
    
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
    
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }

    // OPTIONAL Added method to adjust lock and rotate to the desired orientation
//    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
//
//        self.lockOrientation(orientation)
//
//        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
//        UINavigationController.attemptRotationToDeviceOrientation()
//    }
}
