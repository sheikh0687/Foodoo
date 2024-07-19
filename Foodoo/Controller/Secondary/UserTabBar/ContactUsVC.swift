//
//  ContactUsVC.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 10/04/24.
//

import UIKit
import LanguageManager_iOS

class ContactUsVC: UIViewController {
    
    @IBOutlet weak var txt_Message: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txt_Message.addHint("Type something".localiz())
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
    
    @IBAction func btn_Submit(_ sender: UIButton) {
        if self.txt_Message.hasText {
            contactInfo()
        } else {
            self.alert(alertmessage: "Please enter the message")
        }
    }
}

extension ContactUsVC {
    
    func contactInfo()
    {
        var paramDict:[String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["name"] = k.emptyString as AnyObject
        paramDict["contact_number"] = k.emptyString as AnyObject
        paramDict["email"] = k.emptyString as AnyObject
        paramDict["feedback"] = txt_Message.text as AnyObject
        
        print(paramDict)
        
        Api.shared.send_Feedback(self, paramDict) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName,
                                        message: "We will contact you soon",
                                        delegate: nil,
                                        parentViewController: self) { bool in
                self.dismiss(animated: true)
            }
        }
    }
}
