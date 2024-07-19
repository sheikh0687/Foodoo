//
//  ReferFriendVC.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 10/04/24.
//

import UIKit
import LanguageManager_iOS

class ReferFriendVC: UIViewController {

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
    
    @IBAction func btn_InviteFrnd(_ sender: UIButton) {
        Utility.doShare(k.emptyString, "Please download the app from the provided url", self)
    }
}
