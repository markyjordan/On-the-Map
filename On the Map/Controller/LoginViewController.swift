//
//  LoginViewController.swift
//  On the Map
//
//  Created by Marky Jordan on 11/1/20.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class LoginViewController: UIViewController, LoginButtonDelegate {

    // MARK: - Outlets/Properties
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: CustomButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        // lock the view orientation to portrait mode
        AppUtility.lockOrientation(.portrait)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
        // reset the view orientation when view is being removed
        AppUtility.lockOrientation(.all)
    }
    
    // MARK: - Actions
    
    // method to call when user taps login button
    
    // method to call when user taps signup button
    
    // MARK: - Facebook Authentication
    
    // setup facebook login button
    private func setupFacebookLoginButton() {
        let button = FBLoginButton()
        
        // request additional read permissions
        button.permissions = ["public_profile", "email"]
        
        // set button layout constraints and add it to the view
    }
    
    // function to check for an existing facebook access token at load
//    if let token = AccessToken.current,!token.isExpired {
//            // User is logged in, do work such as go to next view controller.
//    }
    
    // MARK: - Helper Methods
    
}

