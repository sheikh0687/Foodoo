//
//  OtpVC.swift
//  FoodooRestaurant
//
//  Created by Techimmense Software Solutions on 17/04/24.
//

import UIKit

class OtpVC: UIViewController {

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
}
