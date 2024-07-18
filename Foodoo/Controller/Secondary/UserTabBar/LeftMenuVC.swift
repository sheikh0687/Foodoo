//
//  LeftMenuVC.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 08/04/24.
//

import UIKit

struct model_Data {
    var name: String?
    var img: UIImage?
}

class LeftMenuVC: UIViewController {

    @IBOutlet weak var table_View: UITableView!
    @IBOutlet weak var table_Height: NSLayoutConstraint!
    
    var arrOf_LeftMenu = [model_Data]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table_View.register(UINib(nibName: "ToggleCell", bundle: nil), forCellReuseIdentifier: "ToggleCell")
        self.arrOf_LeftMenu = 
        [
            model_Data(name: "Home",img: UIImage(named: "HomeMenu")),
            model_Data(name: "Change Password",img: UIImage(named: "ChangePassword")),
            model_Data(name: "Wallet",img: UIImage(named: "Wallet")),
            model_Data(name: "Money Saved & CO2e avoide",img: UIImage(named: "solar_hand-money-broken")),
            model_Data(name: "Language",img: UIImage(named: "language")),
            model_Data(name: "FAQ",img: UIImage(named: "Question")),
            model_Data(name: "Privacy policy",img: UIImage(named: "shield-tick")),
            model_Data(name: "Write to us",img: UIImage(named: "sms-edit")),
            model_Data(name: "Term of services",img: UIImage(named: "Term")),
            model_Data(name: "Logout",img: UIImage(named: "Logout"))
        ]
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
}
