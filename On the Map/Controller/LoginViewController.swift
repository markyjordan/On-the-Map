//
//  LoginViewController.swift
//  On the Map
//
//  Created by Marky Jordan on 11/1/20.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class LoginViewController: UIViewController {

    // MARK: - Outlets/Properties
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: CustomButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - Life Cycle Methods
    
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
    
    
    
}

