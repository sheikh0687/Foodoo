//
//  UserTabBarVC.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 03/04/24.
//

import UIKit

class UserTabBarVC: UITabBarController {

    var indexSelect = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
        self.selectedIndex = indexSelect
        UITabBar.appearance().unselectedItemTintColor = .white
        UITabBar.appearance().barTintColor = R.color.main()
    }
}
