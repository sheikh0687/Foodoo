//
//  PresentTopUpVC.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 10/04/24.
//

import UIKit

class PresentTopUpVC: UIViewController {

    @IBOutlet weak var lbl_FinalAmount: UILabel!
    @IBOutlet weak var view_Main: UIView!
    
    @IBOutlet weak var btn_10Ot: UIButton!
    @IBOutlet weak var btn_20Ot: UIButton!
    @IBOutlet weak var btn_30Ot: UIButton!
    @IBOutlet weak var btn_40Ot: UIButton!
    @IBOutlet weak var btn_50Ot: UIButton!
    @IBOutlet weak var btn_100Ot: UIButton!
    @IBOutlet weak var btn_150Ot: UIButton!
    
    var amount:String!
    
    var cloNavigate:((_ amount: String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        view_Main.clipsToBounds = true
        view_Main.layer.cornerRadius = 40
        view_Main.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        let buttons = [btn_10Ot, btn_20Ot, btn_30Ot, btn_40Ot, btn_50Ot, btn_100Ot, btn_150Ot]

        // Clear all button backgrounds
        buttons.forEach { $0?.backgroundColor = .clear }

        // Set the clicked button background
        sender.backgroundColor = R.color.main()
        
        lbl_FinalAmount.text = sender.titleLabel?.text
        amount = sender.titleLabel?.text
    }
    
    @IBAction func btn_Cancel(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btn_TopUP(_ sender: UIButton) {
        amount = amount.replacingOccurrences(of: "$", with: "").trimmingCharacters(in: .whitespaces)
        cloNavigate?(amount)
        self.dismiss(animated: true)
    }
}
