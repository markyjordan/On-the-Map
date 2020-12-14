//
//  LoginVC.swift
//  On the Map
//
//  Created by Marky Jordan on 11/1/20.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class LoginVC: UIViewController, UITextFieldDelegate {

    // MARK: - Outlets/Properties
    
    @IBOutlet weak var verticalStackView: UIStackView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var facebookLoginButton = FBLoginButton()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup views
        setupLoginButton()
        setupFacebookLoginButton()
        
        // configure Facebook OAuth
        setupFacebookOAuth()
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
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        setLoggingIn(true)
        
        UdacityClient.login(email: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "", completionHandler: handleLoginResponse(success:error:))
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        setLoggingIn(true)
        
        UIApplication.shared.open(UdacityClient.Endpoints.signUp.url, options: [:], completionHandler: nil)
    }

    
    // MARK: - Helper Methods
    
    // login network request completionHandler
    func handleLoginResponse(success: Bool, error: Error?) {
        setLoggingIn(false)
        
        if success {
            performSegue(withIdentifier: "loginTapped", sender: nil)
        } else {
            // show an alert vc
        }
    }
    
    // set login button properties
    private func setupLoginButton() {
        loginButton.layer.cornerRadius = Constants.buttonCornerRadius
    }
    
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
        
        // set properties
        let buttonTitle = NSAttributedString(string: "Sign In with Facebook")
        facebookLoginButton.setAttributedTitle(buttonTitle, for: .normal)
        
        // add button to the view and set layout constraints
        view.addSubview(facebookLoginButton)
        
        facebookLoginButton.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            facebookLoginButton.topAnchor.constraint(equalTo: <#T##NSLayoutAnchor<NSLayoutYAxisAnchor>#>, constant: <#T##CGFloat#>)
            facebookLoginButton.centerXAnchor.constraint(equalTo: <#T##NSLayoutAnchor<NSLayoutXAxisAnchor>#>, constant: <#T##CGFloat#>)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupFacebookOAuth() {
        // function to check for an existing facebook access token at view load
        if let token = AccessToken.current,!token.isExpired {
            // user is loggin in
            
        }
        
        // request additional read permissions for facebook OAuth
        facebookLoginButton.permissions = ["public_profile", "email"]
    }
}

