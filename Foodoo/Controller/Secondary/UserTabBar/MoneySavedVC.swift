//
//  MoneySavedVC.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 10/04/24.
//

import UIKit
import LanguageManager_iOS

class MoneySavedVC: UIViewController {

    @IBOutlet weak var lbl_Money: UILabel!
    @IBOutlet weak var lbl_C02e: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetProfile()
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
}

extension MoneySavedVC {
    
    func GetProfile()
    {
        Api.shared.get_Profile(self) { responseData in
            let obj = responseData
            self.lbl_Money.text = "\(obj.save_money ?? "") CAD"
            self.lbl_C02e.text = "\(obj.co2e ?? "") KWH"
        }
    }
    
}
