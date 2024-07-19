//
//  UserHomeVC.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 03/04/24.
//

import UIKit
import LanguageManager_iOS

class UserHomeVC: UIViewController {
    
    @IBOutlet weak var shop_CollectionView: UICollectionView!
    @IBOutlet weak var rest_CollectionView: UICollectionView!
    @IBOutlet weak var mysteryMix_CollectionVw: UICollectionView!
    @IBOutlet weak var dailyDeal_CollectionVw: UICollectionView!
    @IBOutlet weak var newOnBoard_CollectionVw: UICollectionView!
    @IBOutlet weak var recommendRes_CollectionVw: UICollectionView!
    @IBOutlet weak var lbl_Address: UILabel!
    @IBOutlet weak var lbl_SearchBar: UILabel!
    
    var arr_ShopCategory: [Res_Category] = []
    var arr_AllResList: [Res_AllRestaurant] = []
    var arr_MysteryMix: [Res_FilterProduct] = []
    var arr_DailyDeal: [Res_FilterProduct] = []
    
    var address:String! = ""
    var lat = 0.0
    var lon = 0.0
    
    var category_Id: String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerAllCollection()
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(address_Picker))
        lbl_Address.isUserInteractionEnabled = true
        lbl_Address.addGestureRecognizer(tapGesture1)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(rest_Search))
        lbl_SearchBar.isUserInteractionEnabled = true
        lbl_SearchBar.addGestureRecognizer(tapGesture2)
        Utility.getCurrentAddress { address in
            self.lbl_Address.text = address
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
        WebGetCategory()
        WebGetAllRestaurant()
        WebGetMagicBags()
        WebGetDiscountFood()
    }
    
    @objc func address_Picker()
    {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "AddressPickerVC") as! AddressPickerVC
        vc.locationPickedBlock = {(addressCordinate, latVal, lonVal, addressVal) in
            self.lbl_Address.text = addressVal
            self.address = addressVal
            self.lat = latVal
            self.lon = lonVal
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func rest_Search()
    {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ResSeeAllVC") as! ResSeeAllVC
        vc.is_From = "ShopCategory"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_Toggle(_ sender: UIButton) {
        if LanguageManager.shared.isRightToLeft {
            toggleRight()
        } else {
           toggleLeft()
        }
    }
    
    @IBAction func btn_Notification(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotifyVC") as! NotifyVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_Filter(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_SeeAllRes(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResSeeAllVC") as! ResSeeAllVC
        vc.is_From = "Res"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_SeeMysteryMix(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResSeeAllVC") as! ResSeeAllVC
        vc.is_From = "Magic"
        vc.filter_Type = "Magic Food"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_SeeDailyDeal(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResSeeAllVC") as! ResSeeAllVC
        vc.is_From = "Discount"
        vc.filter_Type = "Item"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: Api
extension UserHomeVC {
    
    func WebGetCategory()
    {
        Api.shared.all_Category(self) { responseData in
            if responseData.count > 0 {
                self.arr_ShopCategory = responseData
            } else {
                self.arr_ShopCategory = []
            }
            self.shop_CollectionView.reloadData()
        }
    }
    
    func WebGetAllRestaurant()
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        paramDict["token"] = k.emptyString as AnyObject
        paramDict["cat_id"] = k.emptyString as AnyObject
        
        
        print(paramDict)
        
        Api.shared.restaurant_Lists(self, paramDict) { responseData in
            if responseData.count > 0 {
                self.arr_AllResList = responseData
            } else {
                self.arr_AllResList = []
            }
            self.rest_CollectionView.reloadData()
            self.newOnBoard_CollectionVw.reloadData()
            self.recommendRes_CollectionVw.reloadData()
        }
    }
    
    func WebGetMagicBags()
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["token"] = k.emptyString as AnyObject
        paramDict["cat_id"] = k.emptyString as AnyObject
        paramDict["rest_id"] = k.emptyString as AnyObject
        paramDict["size"] = k.emptyString as AnyObject
        paramDict["type"] = "Magic Food" as AnyObject
        paramDict["lat"] = "" as AnyObject
        paramDict["lon"] = "" as AnyObject
        
        print(paramDict)
        
        Api.shared.filter_Products(self, paramDict) { responseData in
            DispatchQueue.main.async {
                if responseData.count > 0 {
                    self.arr_MysteryMix = responseData
                } else {
                    self.arr_MysteryMix = []
                }
                self.mysteryMix_CollectionVw.reloadData {}
            }
        }
    }
    
    func WebGetDiscountFood()
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["token"] = k.emptyString as AnyObject
        paramDict["cat_id"] = k.emptyString as AnyObject
        paramDict["rest_id"] = k.emptyString as AnyObject
        paramDict["size"] = k.emptyString as AnyObject
        paramDict["type"] = "Item" as AnyObject
        paramDict["lat"] = "" as AnyObject
        paramDict["lon"] = "" as AnyObject
        
        print(paramDict)
        
        Api.shared.filter_Products(self, paramDict) { responseData in
            DispatchQueue.main.async {
                if responseData.count > 0 {
                    self.arr_DailyDeal = responseData
                } else {
                    self.arr_DailyDeal = []
                }
                self.dailyDeal_CollectionVw.reloadData {}
            }
        }
    }
    
    func AddFavProvider(provider_Id: String)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["provider_id"] = provider_Id as AnyObject
        
        print(paramDict)
        
        Api.shared.fav_AndUnFavProvider(self, paramDict) { responseData in
            if responseData.status == "1" {
                self.WebGetAllRestaurant()
            }
        }
    }
}

