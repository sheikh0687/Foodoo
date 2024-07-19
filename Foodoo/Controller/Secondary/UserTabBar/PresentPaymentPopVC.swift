//
//  PresentPaymentPopVC.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 04/05/24.
//

import UIKit

class PresentPaymentPopVC: UIViewController {

    @IBOutlet weak var view_Main: UIView!
    @IBOutlet weak var popUp_Img: UIImageView!
    
    @IBOutlet weak var lbl_Message: UILabel!
    @IBOutlet weak var lbl_Description: UILabel!
    
    @IBOutlet weak var btn_Pick: UIButton!
    
    var cloBack:(() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if is_Navigate == "Order" {
            view_Main.backgroundColor = UIColor.secondarySystemFill
            popUp_Img.image = R.image.group18221()
            lbl_Message.text = "Order placed successfully".localiz()
            lbl_Message.textColor = .white
            lbl_Description.text = "The order has been created now its time to go and pick the food".localiz()
            lbl_Description.textColor = .white
            btn_Pick.setTitle("Pickup the order".localiz(), for: .normal)
        } else {
            view_Main.backgroundColor = UIColor.secondarySystemGroupedBackground
            popUp_Img.image = UIImage(named: "Wallet Success")
            lbl_Message.text = "yuuuupi".localiz()
            lbl_Message.textColor = .lightGray
            lbl_Description.text = "Top up successfully done".localiz()
            lbl_Description.textColor = .black
            btn_Pick.setTitle("Back to home".localiz(), for: .normal)
        }
    }
    
    @IBAction func btn_Pick(_ sender: UIButton) {
        if is_Navigate == "Order" {
            self.dismiss(animated: true)
        } else {
            self.cloBack?()
            self.dismiss(animated: true)
        }
    }
}
