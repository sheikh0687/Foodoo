//
//  ChangePasswordVC.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 06/05/24.
//

import UIKit
import LanguageManager_iOS

class ChangePasswordVC: UIViewController {

    @IBOutlet weak var txt_CurrentPassword: UITextField!
    @IBOutlet weak var txt_NewPassword: UITextField!
    @IBOutlet weak var txt_ConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        if LanguageManager.shared.isRightToLeft {
            toggleRight()
        } else {
           toggleLeft()
        }
    }
    
    
    @IBAction func btn_Save(_ sender: UIButton) {
        if txt_CurrentPassword.hasText && txt_NewPassword.hasText && txt_CurrentPassword.hasText {
            ChangePassword()
        } else {
            self.alert(alertmessage: "Please enter the required details".localiz())
        }
    }
}

extension ChangePasswordVC {
    
    func ChangePassword()
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        paramDict["password"] = txt_NewPassword.text as AnyObject
        paramDict["old_password"] = txt_CurrentPassword.text as AnyObject
        
        print(paramDict)
        
        Api.shared.update_Password(self, paramDict) { responseData in
            if responseData.status == "1" {
                self.alert(alertmessage: "Your password updated successfully".localiz())
            } else {
                debugPrint("Something went wrong")
            }
        }
    }
}
