//
//  PresentPopVC.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 01/05/24.
//

import UIKit

class PresentPopVC: UIViewController {

    var cloGoToCart:(() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func btn_Dismiss(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btn_GoToCart(_ sender: UIButton) {
        self.cloGoToCart?()
        self.dismiss(animated: true)
    }
}
