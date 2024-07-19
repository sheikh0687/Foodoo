//
//  UserWalletVC.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 10/04/24.
//

import UIKit
import LanguageManager_iOS

class UserWalletVC: UIViewController {

    @IBOutlet weak var tarnction_TableView: UITableView!
    @IBOutlet weak var lbl_Wallet: UILabel!
    
    var arr_WalletTransaction: [Res_TransactionHistory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tarnction_TableView.register(UINib(nibName: "WalletTransactionCell", bundle: nil), forCellReuseIdentifier: "WalletTransactionCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        GetWalletTransaction()
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        if LanguageManager.shared.isRightToLeft {
            toggleRight()
        } else {
           toggleLeft()
        }
    }
    
    @IBAction func btn_TopUp(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(identifier: "PresentTopUpVC") as! PresentTopUpVC
        vc.cloNavigate = {( amount ) in
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "PaymentVC") as! PaymentVC
            is_Navigate = "TopUP"
            print(amount)
            vc.amount = Double(amount) ?? 0.0
            self.navigationController?.pushViewController(vc, animated: true)
        }
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

extension UserWalletVC {
    
    func GetWalletTransaction()
    {
        Api.shared.wallet_TransactionHistory(self) { responseData in
            let obj = responseData
            self.lbl_Wallet.text = "$\(obj.wallet ?? "")"
            
            if let obj_Response = obj.result {
                if obj_Response.count > 0 {
                    self.arr_WalletTransaction = obj_Response
                } else {
                    self.arr_WalletTransaction = []
                }
                self.tarnction_TableView.reloadData()
            }
        }
    }
}

extension UserWalletVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_WalletTransaction.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WalletTransactionCell", for: indexPath) as! WalletTransactionCell
        let obj = self.arr_WalletTransaction[indexPath.row]
        cell.lbl_WalletAmount.text = "+$\(obj.total_amount ?? "") \("Top Up to Wallet".localiz())"
        cell.lbl_DateTime.text = obj.date_time ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
