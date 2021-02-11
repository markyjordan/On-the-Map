//
//  AddLocationVC.swift
//  On the Map
//
//  Created by Marky Jordan on 11/17/20.
//

import Foundation
import UIKit
import MapKit

class AddLocationVC: UIViewController, UITextFieldDelegate {
    
    //  MARK: - Outlets/Properties
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var webLinkTextField: UITextField!
    @IBOutlet weak var findLocationButton: UIButton!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    
    //  MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  setup views
        setupFindLocationButton()
        
        //  hide the keyboard when users taps anywhere outside a textfield
        self.dismissKeyboardOnTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    //  MARK: - Navigation
    
    //  dismiss the 'Add Location' view
    @IBAction func cancelAddLocation(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //  find the user-inputted location
    @IBAction func findLocation(_ sender: Any) {
        setLoading(true)
        let location = locationTextField.text
        
        //  check to see that the provided url can be opened
        guard let url = URL(string: self.webLinkTextField.text!), UIApplication.shared.canOpenURL(url) else {
            setLoading(false)
            
            //  show an alert for an invalid URL
        }
        
        geocodeLocation(location ?? "")
    }
    
    
    //  MARK: - Helper Methods
    
    //  set 'find location' button properties
    private func setupFindLocationButton() {
        findLocationButton.layer.cornerRadius = Constants.buttonCornerRadius
    }
    
    //  set loading state
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
        
        //  enable/disable UI views
        DispatchQueue.main.async {
            self.locationTextField.isEnabled = !loading
            self.webLinkTextField.isEnabled = !loading
            self.findLocationButton.isEnabled = !loading
        }
    }
    
    private func geocodeLocation(_ location: String) {
        CLGeocoder().geocodeAddressString(location) { (placemark, error) in
            if let error = error {
                Alert.showLocationNotFound(on: self, message: error.localizedDescription as! Error)
                self.setLoading(false)
            } else {
                var location: CLLocation?
                
                if let marker = placemark, placemark.count > 0 {
                    location = marker.first?.location
                }
                
                if let location = location {
                    self.loadNewLocation(location.coordinate)
                } else {
                    self.showAlert(message: "Please try again later.", title: "Error")
                    self.setLoading(false)
                    print("There was an error.")
                }
                
            }
        }
    }
    
    private func loadNewLocation(_ coordinate: CLLocationCoordinate2D) {
        let controller = storyboard?.instantiateViewController(identifier: "LocationPreviewVC") as! LocationPreviewVC
    }
    
}
