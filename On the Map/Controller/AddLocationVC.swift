//
//  AddLocationVC.swift
//  On the Map
//
//  Created by Marky Jordan on 11/17/20.
//

import Foundation
import UIKit

class AddLocationVC: UIViewController {
    
    // MARK: - Outlets/Properties
    
    
    
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
    
    
}
