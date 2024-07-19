//
//  LeftMenuVC.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 08/04/24.
//

import UIKit
import SlideMenuControllerSwift

struct model_Data {
    var name: String?
    var img: UIImage?
}

class LeftMenuVC: UIViewController {

    @IBOutlet weak var table_View: UITableView!
    @IBOutlet weak var table_Height: NSLayoutConstraint!
    
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_Mobile: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    
    var arrOf_LeftMenu = [model_Data]()
    
    @IBOutlet var main_View: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        main_View.clipsToBounds = true
        main_View.layer.cornerRadius = 40
        main_View.layer.maskedCorners = [ .layerMaxXMinYCorner]
        GetProfile()
        self.table_View.register(UINib(nibName: "ToggleCell", bundle: nil), forCellReuseIdentifier: "ToggleCell")
        self.arrOf_LeftMenu = 
        [
            model_Data(name: "Home".localiz(),img: UIImage(named: "HomeMenu")),
            model_Data(name: "Change Password".localiz(),img: UIImage(named: "ChangePassword")),
            model_Data(name: "Wallet".localiz(),img: UIImage(named: "Wallet")),
            model_Data(name: "Money Saved & CO2e avoide".localiz(),img: UIImage(named: "solar_hand-money-broken")),
            model_Data(name: "Language".localiz(),img: UIImage(named: "language")),
            model_Data(name: "FAQ".localiz(),img: UIImage(named: "Question")),
            model_Data(name: "Privacy policy".localiz(),img: UIImage(named: "shield-tick")),
            model_Data(name: "Write to us".localiz(),img: UIImage(named: "sms-edit")),
            model_Data(name: "Term of services".localiz(),img: UIImage(named: "Term")),
            model_Data(name: "Logout".localiz(),img: UIImage(named: "Logout"))
        ]
    }
    
    @IBAction func btn_Invite(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ReferFriendVC") as! ReferFriendVC
        let NavVC = UINavigationController(rootViewController: vc)
        self.slideMenuController()?.changeMainViewController(NavVC, close: true)
    }
}

extension LeftMenuVC {
    
    func GetProfile()
    {
        Api.shared.get_Profile(self) { responseData in
            let obj = responseData
            self.lbl_Name.text = "\(obj.first_name ?? "") \(obj.last_name ?? "")"
            self.lbl_Mobile.text = obj.mobile ?? ""
            
            if Router.BASE_IMAGE_URL != obj.image {
                Utility.setImageWithSDWebImage(obj.image ?? "", self.img)
            } else {
                self.img.image = R.image.profile_ic()
            }
        }
    }
}

extension LeftMenuVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.arrOf_LeftMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToggleCell", for: indexPath) as! ToggleCell
        cell.lbl_Name.text = arrOf_LeftMenu[indexPath.row].name ?? ""
        cell.img.image = arrOf_LeftMenu[indexPath.row].img
        self.table_Height.constant = CGFloat(self.arrOf_LeftMenu.count * 45)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let vcHome = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserTabBarVC") as! UserTabBarVC
        let vc1 = UINavigationController(rootViewController: vcHome)
        
        let vcNav = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
        let vc2 = UINavigationController(rootViewController: vcNav)
        
        let vcNav1 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserWalletVC") as! UserWalletVC
        let vc3 = UINavigationController(rootViewController: vcNav1)
        
        let vcNav2 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MoneySavedVC") as! MoneySavedVC
        let vc4 = UINavigationController(rootViewController: vcNav2)
        
        let vcNav3 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LanguageVC") as! LanguageVC
        let vc5 = UINavigationController(rootViewController: vcNav3)
        
        let vcNav4 = R.storyboard.main().instantiateViewController(withIdentifier: "FAQ_sVC") as! FAQ_sVC
        let vc6 = UINavigationController(rootViewController: vcNav4)
        
//        let vcNav5 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PrivacyPolicyVC") as! PrivacyPolicyVC
//        let vc7 = UINavigationController(rootViewController: vcNav5)
        
        let vcNav6 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContactUsVC") as! ContactUsVC
        let vc8 = UINavigationController(rootViewController: vcNav6)
        
//        let vcNav7 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TermsAndConditionVC") as! TermsAndConditionVC
//        let vc9 = UINavigationController(rootViewController: vcNav7)
        
//        let vcNav8 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PrivacyPolicyVC") as! PrivacyPolicyVC
//        let vc10 = UINavigationController(rootViewController: vcNav8)
//        
//        
//        let vcNav9 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TermsAndConditionVC") as! TermsAndConditionVC
//        let vc11 = UINavigationController(rootViewController: vcNav9)
        
        if indexPath.row == 0
        {
            self.slideMenuController()?.changeMainViewController(vc1, close: true) // Home
        }
        
        else if indexPath.row == 1
        {
            self.slideMenuController()?.changeMainViewController(vc2, close: true) // My account
        }
        
        else if indexPath.row == 2
        {
            self.slideMenuController()?.changeMainViewController(vc3, close: true) // Invite Friends
        }
        
        else if indexPath.row == 3
        {
            self.slideMenuController()?.changeMainViewController(vc4, close: true)
        }
        
        else if indexPath.row == 4
        {
            self.slideMenuController()?.changeMainViewController(vc5, close: true)
        }
        
        else if indexPath.row == 5
        {
            self.slideMenuController()?.changeMainViewController(vc6, close: true)
        }
        
        else if indexPath.row == 6
        {
//            self.slideMenuController()?.changeMainViewController(vc7, close: true) // Change Password
        }
        
        else if indexPath.row == 7
        {
            self.slideMenuController()?.changeMainViewController(vc8, close: true) // Notification
        }
        
        else if indexPath.row == 8
        {
//            self.slideMenuController()?.changeMainViewController(vc9, close: true) // Privacy Policy
        }
        
        else if indexPath.row == 9
        {
            UserDefaults.standard.removeObject(forKey: k.session.status)
            UserDefaults.standard.synchronize()
            Switcher.updateRootVC()
        }
    }
}
