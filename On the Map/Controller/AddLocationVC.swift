//
//  AddLocationVC.swift
//  On the Map
//
//  Created by Marky Jordan on 11/17/20.
//

import Foundation
import UIKit

class AddLocationVC: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets/Properties
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var webLinkTextField: UITextField!
    @IBOutlet weak var findLocationButton: CustomButton!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide the keyboard when users taps anywhere outside a textfield
        self.dismissKeyboardOnTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    // MARK: - Navigation
    
    // dismiss the 'add location' view
    @IBAction func cancelAddLocation(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // find the user input location
    @IBAction func findLocation(_ sender: Any) {
        
    }
    
    // MARK: - Helper Methods
    
    // set loading state
    private func setLoading(_ loading: Bool) {
        if loading {
            DispatchQueue.main.async {
                self.activityIndicatorView.startAnimating()
                self.buttonEnabled(false, button: self.findLocationButton)
            }
        } else {
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.buttonEnabled(true, button: self.findLocationButton)
            }
        }
    }
    
}
