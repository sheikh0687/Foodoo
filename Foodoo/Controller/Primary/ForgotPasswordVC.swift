//
//  ForgotPasswordVC.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 03/04/24.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var txt_Email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_Send(_ sender: UIButton) {
        if txt_Email.hasText {
            UpdatePassword()
        } else {
            self.alert(alertmessage: "Please enter the valid email".localiz())
        }
    }
    
    func UpdatePassword()
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["email"] = txt_Email.text as AnyObject
        
        Api.shared.forgot_Password(self, paramDict) { responseData in
            let obj = responseData
            if obj.status == "1" {
                Utility.showAlertWithAction(withTitle: k.appName, message: "New password has been sent to your email".localiz(), delegate: nil, parentViewController: self) { bool in
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                Utility.showAlertMessage(withTitle: k.appName, message: obj.result ?? "", delegate: nil, parentViewController: self)
            }
        }
    }
}
