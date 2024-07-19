//
//  Swicther.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 10/04/24.
//

import Foundation
import UIKit
import SlideMenuControllerSwift

class Switcher {
    
    static func updateRootVC() {
        
        let status = k.userDefault.bool(forKey: k.session.status)
        if status {
            let mainViewController = R.storyboard.main().instantiateViewController(withIdentifier: "UserTabBarVC") as! UserTabBarVC
            let vc = UINavigationController(rootViewController: mainViewController)
            let leftViewController = R.storyboard.main().instantiateViewController(withIdentifier: "LeftMenuVC") as! LeftMenuVC
            let rightViewController = R.storyboard.main().instantiateViewController(withIdentifier: "LeftMenuVC") as! LeftMenuVC
            let rootVC = SlideMenuController(mainViewController: vc, leftMenuViewController: leftViewController, rightMenuViewController: rightViewController)
            kAppDelegate.window?.rootViewController = rootVC
            kAppDelegate.window?.makeKeyAndVisible()
        } else {
            let rootVC = R.storyboard.main().instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            let nav = UINavigationController(rootViewController: rootVC)
            nav.isNavigationBarHidden = false
            kAppDelegate.window!.rootViewController = nav
            kAppDelegate.window?.makeKeyAndVisible()
        }
    }
}
