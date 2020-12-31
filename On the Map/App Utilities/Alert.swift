//
//  Alert.swift
//  On the Map
//
//  Created by Marky Jordan on 11/20/20.
//

import UIKit

struct Alert {
    
    // MARK: - Alert Views
    
    // basic alert with single "OK" dismiss action
    private static func showBasicAlert(on vc: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Alert Styles
    
    // failed network connection
    static func showNetworkError(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "Network Error", message: "Unable to connect to the interwebz.")
    }
    
    // incorrect login credentials (email and password)
    static func showInvalidLogin(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "Log In Failed", message: "Please enter a valid email and password to continue.")
    }
    
    // invalid location url
    static func showInvalidURL(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "Invalid Link", message: "Cannot open URL.")
    }
    
    // failed to forward location geocode
    static func showLocationNotFound(on vc: UIViewController, message: Error) {
        showBasicAlert(on: vc, title: "Location Not Found", message: message.localizedDescription)
    }
    
    // failed to post geocode map/pin data to server
    static func showFailedToPost(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "Add Location Failed", message: "Please try again later.")
    }
    
}
