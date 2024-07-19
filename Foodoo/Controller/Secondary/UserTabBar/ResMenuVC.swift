//
//  ResMenuVC.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 27/04/24.
//

import UIKit

class ResMenuVC: UIViewController {

    @IBOutlet weak var menu_TableView: UITableView!
    @IBOutlet weak var btn_ItemOt: UIButton!
    @IBOutlet weak var btn_MagicBagOt: UIButton!
    
    var arr_BakeryMenu: [Res_FilterProduct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu_TableView.register(UINib(nibName: "BakeryMenuCell", bundle: nil), forCellReuseIdentifier: "BakeryMenuCell")
        btn_ItemOt.backgroundColor = R.color.main()
        btn_ItemOt.setTitleColor(.white, for: .normal)
        btn_MagicBagOt.backgroundColor = .clear
        btn_MagicBagOt.setTitleColor(.black, for: .normal)
        GetFilterProducts("Item")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_Items(_ sender: UIButton) {
        btn_ItemOt.backgroundColor = R.color.main()
        btn_ItemOt.setTitleColor(.white, for: .normal)
        btn_MagicBagOt.backgroundColor = .clear
        btn_MagicBagOt.setTitleColor(.black, for: .normal)
        GetFilterProducts("Item")
    }
    
    @IBAction func btn_MagicBag(_ sender: UIButton) {
        btn_ItemOt.backgroundColor = .clear
        btn_ItemOt.setTitleColor(.black, for: .normal)
        btn_MagicBagOt.backgroundColor = R.color.main()
        btn_MagicBagOt.setTitleColor(.white, for: .normal)
        GetFilterProducts("Magic Food")
    }
}

extension ResMenuVC {
    
    func GetFilterProducts(_ type: String)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["token"] = k.emptyString as AnyObject
        paramDict["cat_id"] = k.emptyString as AnyObject
        paramDict["rest_id"] = k.emptyString as AnyObject
        paramDict["size"] = k.emptyString as AnyObject
        paramDict["type"] = type as AnyObject
        paramDict["lat"] = "" as AnyObject
        paramDict["lon"] = "" as AnyObject
        
        print(paramDict)
        
        Api.shared.filter_Products(self, paramDict) { responseData in
            DispatchQueue.main.async {
                if responseData.count > 0 {
                    self.arr_BakeryMenu = responseData
                } else {
                    self.arr_BakeryMenu = []
                }
                self.menu_TableView.reloadData {}
            }
        }
    }
}

extension ResMenuVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_BakeryMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BakeryMenuCell", for: indexPath) as! BakeryMenuCell
        let obj = self.arr_BakeryMenu[indexPath.row]
        
        cell.lbl_ItemName.text = obj.item_name ?? ""
        cell.lbl_ProviderName.text = obj.rest_details?.provider_name ?? ""
        cell.lbl_ItemPrice.text = "$\(obj.item_price ?? "")"
        
        if obj.product_images?.count ?? 0 > 0 {
            if Router.BASE_IMAGE_URL != obj.product_images?[0].image {
                Utility.setImageWithSDWebImage(obj.product_images?[0].image ?? "", cell.img)
            } else {
                cell.img.image = R.image.placeholder()
            }
        } else {
            cell.img.image = R.image.chickenSkewersWithSlicesSweetPeppersDill7()
        }
        
        cell.cloViewDetail = {() in
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "UserOrderDetailVC") as! UserOrderDetailVC
            vc.product_Id = self.arr_BakeryMenu[indexPath.row].id ?? ""
            vc.provider_Id = self.arr_BakeryMenu[indexPath.row].provider_id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
