//
//  TabBarVC.swift
//  On the Map
//
//  Created by Marky Jordan on 11/28/20.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // unhighlight unselected tab bar items
        self.tabBar.unselectedItemTintColor = .darkGray
    }
}
