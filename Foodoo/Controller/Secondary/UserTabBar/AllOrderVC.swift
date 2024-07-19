//
//  AllOrderVC.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 04/04/24.
//

import UIKit

class AllOrderVC: UIViewController {
    
    @IBOutlet weak var ordered_TableView: UITableView!
    @IBOutlet weak var btn_InprogressOt: UIButton!
    @IBOutlet weak var btn_CompleteOt: UIButton!
    
    var arr_OrderStatus: [Res_OrderStatus] = []
    var type:String = "Current"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ordered_TableView.register(UINib(nibName: "PlacedOrderCell", bundle: nil), forCellReuseIdentifier: "PlacedOrderCell")
        self.tabBarController?.tabBar.isHidden = false
        btn_InprogressOt.backgroundColor = R.color.main()
        btn_InprogressOt.setTitleColor(.white, for: .normal)
        btn_CompleteOt.backgroundColor = .clear
        btn_CompleteOt.setTitleColor(.black, for: .normal)
        MyOrderList()
    }
    
    @IBAction func btn_InProgress(_ sender: UIButton) {
        btn_InprogressOt.backgroundColor = R.color.main()
        btn_InprogressOt.setTitleColor(.white, for: .normal)
        btn_CompleteOt.backgroundColor = .clear
        btn_CompleteOt.setTitleColor(.black, for: .normal)
        type = "Current"
        MyOrderList()
    }
    
    @IBAction func btn_Complete(_ sender: UIButton) {
        btn_CompleteOt.backgroundColor = R.color.main()
        btn_CompleteOt.setTitleColor(.white, for: .normal)
        btn_InprogressOt.backgroundColor = .clear
        btn_InprogressOt.setTitleColor(.black, for: .normal)
        type = "Complete"
        MyOrderList()
    }
}

extension AllOrderVC {
    
    func MyOrderList()
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["type"] = type as AnyObject
        paramDict["token"] = k.emptyString as AnyObject
        
        print(paramDict)
        
        Api.shared.order_Status(self, paramDict) { responseData in
            let obj = responseData
            if obj.status == "1" {
                if let obj_Res = obj.result {
                    self.arr_OrderStatus = obj_Res
                    self.ordered_TableView.backgroundView = UIView()
                    self.ordered_TableView.reloadData()
                }
            } else {
                self.arr_OrderStatus = []
                self.ordered_TableView.backgroundView = UIView()
                self.ordered_TableView.reloadData()
                Utility.noDataFound("You have no orders".localiz(), tableViewOt: self.ordered_TableView, parentViewController: self)
            }
            self.ordered_TableView.reloadData()
        }
    }
}

extension AllOrderVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_OrderStatus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlacedOrderCell", for: indexPath) as! PlacedOrderCell
        if type == "Current" {
            let obj = self.arr_OrderStatus[indexPath.row]
            
            cell.btn_GiveRatingOt.isHidden = true
            cell.lbl_Progress.isHidden = false
            
            cell.lbl_ProviderName.text = obj.rest_details?.provider_name ?? ""
            cell.lbl_Address.text = obj.rest_details?.provider_streat_address ?? ""
            cell.lbl_OrderId.text = "\("Order Id".localiz()) : \(obj.id ?? "")"
            cell.lbl_OrderOnDate.text = "\(obj.time ?? "") \(obj.date ?? "")"
            cell.lbl_Subtotal.text = "$\(obj.before_discount_amount ?? "")"
            cell.lbl_DeliveryFee.text = "$\(obj.delivery_fee ?? "")0"
            cell.lbl_Discount.text = "$\(obj.total_discount_amount ?? "")"
            cell.lbl_Total.text = "$\(obj.total_amount ?? "")"
            
            if let cartDetails = obj.cart_details {
                cell.bindItems(arr: cartDetails)
            }
            
        } else {
            let obj = self.arr_OrderStatus[indexPath.row]
            
            cell.btn_GiveRatingOt.isHidden = false
            cell.lbl_Progress.isHidden = true
            
            cell.lbl_ProviderName.text = obj.rest_details?.provider_name ?? ""
            cell.lbl_Address.text = obj.rest_details?.provider_streat_address ?? ""
            cell.lbl_OrderId.text = "\("Order Id".localiz()) : \(obj.id ?? "")"
            cell.lbl_OrderOnDate.text = "\(obj.time ?? "") \(obj.date ?? "")"
            cell.lbl_Subtotal.text = "$\(obj.before_discount_amount ?? "")"
            cell.lbl_DeliveryFee.text = "$\(obj.delivery_fee ?? "")0"
            cell.lbl_Discount.text = "$\(obj.total_discount_amount ?? "")"
            cell.lbl_Total.text = "$\(obj.total_amount ?? "")"
            
            if let cartDetails = obj.cart_details {
                cell.bindItems(arr: cartDetails)
            }
            
            cell.cloGiveRating = {() in
                let vc = R.storyboard.main().instantiateViewController(withIdentifier: "RatingProductVC") as! RatingProductVC
                vc.provider_Id = obj.provider_id ?? ""
                vc.req_Id = obj.id ?? ""
                vc.clo_Refresh = {() in
                    self.MyOrderList()
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        return cell
    }
}
