//
//  MyCartVC.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 04/04/24.
//

import UIKit

class MyCartVC: UIViewController {

    @IBOutlet weak var view_1: UIView!
    @IBOutlet weak var view_2: UIView!
    @IBOutlet weak var cart_TableView: UITableView!
    @IBOutlet weak var table_Height: NSLayoutConstraint!
    @IBOutlet weak var lbl_Total: UILabel!
    @IBOutlet weak var scroll_View: UIView!
    @IBOutlet weak var blank_View: UIView!
    
    @IBOutlet weak var lbl_CartTotalAmount: UILabel!
    @IBOutlet weak var lbl_DeliveryFee: UILabel!
    @IBOutlet weak var lbl_ServiceFee: UILabel!
    @IBOutlet weak var lbl_SubTotal: UILabel!
    @IBOutlet weak var lbl_Tax: UILabel!
    
    var arr_CartProduct: [Res_CartDt] = []
    var arr_ProductImage: [Product_images] = []
    
    var total_Amount:String!
    var delivery_Fee:String!
    var total_discount_amount:String!
    var before_discount_amount:String!
    
    var request_Id:String!
    var providerId:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view_2.isHidden = true
        self.view_1.isHidden = false
        self.cart_TableView.register(UINib(nibName: "AddedCartCell", bundle: nil), forCellReuseIdentifier: "AddedCartCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        GetProductCart()
    }
    
    @IBAction func btn_Apply(_ sender: UIButton) {
        view_2.isHidden = false
    }
    
    @IBAction func btn_CheckBox(_ sender: UIButton) {
        view_1.isHidden = false
        view_2.isHidden = true
    }
    
    @IBAction func btn_ProceedToCheck(_ sender: UIButton) {
        PlacedOrder()
    }
}

// MARK: Api
extension MyCartVC {
    
    func GetProductCart()
    {
        Api.shared.cart_Details(self) { responseData in
            let obj = responseData
            self.lbl_Total.text = "$\(obj.total_amount ?? "")"
            self.delivery_Fee = obj.delivery_fee ?? ""
            self.total_discount_amount = obj.total_discount_amount ?? ""
            self.before_discount_amount = obj.before_discount_amount ?? ""
            
            self.lbl_CartTotalAmount.text = "$\(obj.cart_total_amount ?? "")"
            self.lbl_DeliveryFee.text = "$\(obj.delivery_fee ?? "")"
            self.lbl_ServiceFee.text = "$\(obj.service_fee ?? "")"
            self.lbl_SubTotal.text = "$\(obj.sub_total_amount ?? "")"
            self.lbl_Tax.text = "$\(obj.total_tax ?? "")"
            
            if let totalCart = Int(obj.total_cart ?? ""), totalCart != 0 {
                if let items = self.tabBarController?.tabBar.items {
                    let tabItem = items[2]
                    tabItem.badgeValue = "\(totalCart)"
                }
            } else {
                if let items = self.tabBarController?.tabBar.items {
                    let tabItem = items[2]
                    tabItem.badgeValue = nil
                }
            }
            
            if let obj_Response = responseData.result {
                if obj_Response.count > 0 {
                    self.arr_CartProduct = obj_Response
                    self.table_Height.constant = CGFloat(self.arr_CartProduct.count * 140)
                    self.scroll_View.isHidden = false
                    self.blank_View.isHidden = true
                } else {
                    self.arr_CartProduct = []
                    self.arr_ProductImage = []
                    self.scroll_View.isHidden = true
                    self.blank_View.isHidden = false
                }
            }
            self.cart_TableView.reloadData()
        }
    }
    
    func WebUpdateCart(_ cart_Id: String,_ quantity: String,_ type: String)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["cart_id"] = cart_Id as AnyObject
        paramDict["type"] = type as AnyObject
        paramDict["quantity"] = quantity as AnyObject
        
        print(paramDict)
        
        Api.shared.update_AllCart(self, paramDict) { responseData in
            if responseData.status == "1" {
                self.GetProductCart()
            }
        }
    }
    
    func DeleteProductCart(_ card_Id: String)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["cart_id"] = card_Id as AnyObject
        
        print(paramDict)
        
        Api.shared.delete_Cart(self, paramDict) { responseData in
            if responseData.status == "1" {
                Utility.showAlertWithAction(withTitle: k.appName, message: "Product deleted successfully".localiz(), delegate: nil, parentViewController: self) { bool in
                    self.GetProductCart()
                }
            }
        }
    }
    
    func PlacedOrder()
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["total_amount"] = total_Amount as AnyObject
        paramDict["payment_method"] = "Card" as AnyObject
        paramDict["delivery_fee"] = delivery_Fee as AnyObject
        paramDict["total_discount_amount"] = total_discount_amount as AnyObject
        paramDict["before_discount_amount"] = before_discount_amount as AnyObject
        paramDict["delivery_date"] = k.emptyString as AnyObject
        paramDict["delivery_time"] = k.emptyString as AnyObject
        paramDict["address"] = k.emptyString as AnyObject
        paramDict["lat"] = kAppDelegate.CURRENT_LAT as AnyObject
        paramDict["lon"] = kAppDelegate.CURRENT_LON as AnyObject
        paramDict["date"] = Utility.getCurrentDate() as AnyObject
        paramDict["time"] = Utility.getCurrentTime() as AnyObject
        paramDict["delivery_fee_by_admin"] = k.emptyString as AnyObject
        paramDict["offer_id"] = k.emptyString as AnyObject
        paramDict["offer_check_date"] = k.emptyString as AnyObject
        paramDict["offer_code"] = k.emptyString as AnyObject
        
        print(paramDict)
        
        Api.shared.place_Order(self, paramDict) { responseData in
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "PaymentVC") as! PaymentVC
            is_Navigate = "Order"
            vc.amount = Double(self.total_Amount) ?? 0.0
            vc.providerId = self.providerId
            vc.requestId = self.request_Id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension MyCartVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_CartProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddedCartCell", for: indexPath) as! AddedCartCell
        cell.showAnimatedSkeleton()
        let obj = self.arr_CartProduct[indexPath.row]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            cell.lbl_ItemName.text = obj.product_name ?? ""
            cell.lbl_ProviderName.text = obj.rest_details?.provider_name ?? ""
            cell.lbl_Amount.text = "$\(obj.total_amount ?? "")"
            cell.lbl_Quantity.text = obj.quantity ?? ""
            self.total_Amount = obj.total_amount ?? ""
            self.request_Id = obj.id ?? ""
            self.providerId = obj.provider_id ?? ""
            
            if let obj_Image = obj.product_details?.product_images {
                if Router.BASE_IMAGE_URL != obj_Image.first?.image {
                    Utility.setImageWithSDWebImage(obj_Image.first?.image ?? "", cell.item_Img)
                } else {
                    cell.item_Img.image = R.image.placeholder()
                }
            }
            cell.hideSkeleton()
        }
        
        cell.cloAdd = {() in
            let lastNum = Int(obj.quantity ?? "") ?? 0
            let num = +1
            let fQuantity = lastNum + num
            print(fQuantity)
            self.WebUpdateCart(obj.id ?? "", String(fQuantity), "Plus")
        }
        
        cell.cloMinus = {() in
            let lastNum = Int(obj.quantity ?? "") ?? 0
            if lastNum > 1 {
                let num = -1
                let fQuantity = lastNum + num
                print(fQuantity)
                self.WebUpdateCart(obj.id ?? "", String(fQuantity), "Minus")
            } else {
                print("Quantity should be more than 0")
            }
        }
        
        cell.cloDelete = {() in
            self.DeleteProductCart(obj.id ?? "")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

