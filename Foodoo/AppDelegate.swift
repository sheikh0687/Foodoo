//
//  AppDelegate.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 28/03/24.
//

import UIKit
import CoreLocation
import Stripe
import LanguageManager_iOS
import IQKeyboardManagerSwift

let kAppDelegate = UIApplication.shared.delegate as! AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var coordinate1 = CLLocation(latitude: 0.0, longitude: 0.0)
    var coordinate2 = CLLocation(latitude: 0.0, longitude: 0.0)
    var CURRENT_LAT = ""
    var CURRENT_LON = ""
    let language = k.userDefault.value(forKey: k.session.language) as? String
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        LocationManager.sharedInstance.delegate = kAppDelegate
        LocationManager.sharedInstance.startUpdatingLocation()
        if language == nil {
            LanguageManager.shared.defaultLanguage = .deviceLanguage
        } else if LanguageManager.shared.currentLanguage == .en {
            LanguageManager.shared.defaultLanguage = .en
        } else if LanguageManager.shared.currentLanguage == .ar {
            LanguageManager.shared.defaultLanguage = .ar
        } else {
            LanguageManager.shared.defaultLanguage = .tr
        }
        Switcher.updateRootVC()
        IQKeyboardManager.shared.enable = true
        StripeAPI.defaultPublishableKey = "pk_test_51P5rKT2NILLEdEG6EQrPQesnkDXB0ZhKShZad0QydTjsOeEXreHHq55nuhhVKZ5LcJQaH0b7LvAUP78V2BApv1e800t8wiwLp5"
        
        if #available(iOS 13.0, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundEffect = .none
            tabBarAppearance.shadowColor = .clear
            tabBarAppearance.backgroundColor = UIColor.white
            UITabBar.appearance().standardAppearance = tabBarAppearance
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
        }
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
}

extension AppDelegate: LocationManagerDelegate {
    
    func didEnterInCircularArea() {
        print("")
    }
    
    func didExitCircularArea() {
        print("")
    }
    
    
    func tracingLocation(currentLocation: CLLocation) {
        coordinate2 = currentLocation
        print(coordinate2)
        let distanceInMeters = coordinate1.distance(from: coordinate2) // result is in meters
        if distanceInMeters > 250 {
            CURRENT_LAT = String(currentLocation.coordinate.latitude)
            print(CURRENT_LAT)
            CURRENT_LON = String(currentLocation.coordinate.longitude)
            coordinate1 = currentLocation
            if let _ = UserDefaults.standard.value(forKey: "user_id") {
                //self.updateLatLon()
            }
        }
    }
    
    func tracingLocationDidFailWithError(error: NSError) {
        print("tracing Location Error : \(error.description)")
    }
}
