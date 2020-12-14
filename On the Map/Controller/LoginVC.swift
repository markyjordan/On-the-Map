//
//  LoginVC.swift
//  On the Map
//
//  Created by Marky Jordan on 11/1/20.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class LoginVC: UIViewController, UITextFieldDelegate, LoginButtonDelegate {

    // MARK: - Outlets/Properties
    
    @IBOutlet weak var verticalStackView: UIStackView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: CustomButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var facebookLoginButton = FBLoginButton()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        // lock the view orientation to portrait mode
        Utilities.lockOrientation(.portrait)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
        // reset the view orientation when view is being removed
        Utilities.lockOrientation(.all)
    }
    
    
    // MARK: - Navigation
    
    // method to call when user taps login button

    @IBAction func loginButtonTapped(_ sender: Any) {
        setLoggingIn(true)
        
        
    }
    
    // method to call when user taps signup button
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        
    }
    
    
    // MARK: - Helper Methods
    
    // set login state
    func setLoggingIn(_ loggingIn: Bool) {
        if loggingIn {
            DispatchQueue.main.async {
                self.activityIndicatorView.startAnimating()
            }
        } else {
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
            }
        }
        
        // enable/disable UI views
        DispatchQueue.main.async {
            self.emailTextField.isEnabled = !loggingIn
            self.passwordTextField.isEnabled = !loggingIn
            self.loginButton.isEnabled = !loggingIn
            self.signupButton.isEnabled = !loggingIn
        }
    }
    
    // MARK: - Network Request Login Completion Handler
    
    func handleLoginResponse(success: Bool, error: Error?) {
        setLoggingIn(false)
        
        if success {
            performSegue(withIdentifier: "loginTapped", sender: nil)
        } else {
            // show an alert vc
        }
    }
    
    
    // MARK: - UITextField Delegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        <#code#>
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        <#code#>
    }
    
    
    // MARK: - OAuth
    
    // Facebook Authentication
    
    // setup facebook login button
    private func setupFacebookLoginButton() {
        
        // request additional read permissions
        facebookLoginButton.permissions = ["public_profile", "email"]
        
        // add button to the view and set layout constraints
        view.addSubview(facebookLoginButton)
        
        facebookLoginButton.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            facebookLoginButton.topAnchor.constraint(equalTo: <#T##NSLayoutAnchor<NSLayoutYAxisAnchor>#>, constant: <#T##CGFloat#>)
            facebookLoginButton.centerXAnchor.constraint(equalTo: <#T##NSLayoutAnchor<NSLayoutXAxisAnchor>#>, constant: <#T##CGFloat#>)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    // function to check for an existing facebook access token at load
//    if let token = AccessToken.current,!token.isExpired {
//            // User is logged in, do work such as go to next view controller.
//    }
    
}

