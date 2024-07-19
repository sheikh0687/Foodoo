//
//  FavouriteVC.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 04/04/24.
//

import UIKit
import SkeletonView

class FavouriteVC: UIViewController {
    
    @IBOutlet weak var fav_TableView: UITableView!
    @IBOutlet weak var btn_ItemOt: UIButton!
    @IBOutlet weak var btn_RestOt: UIButton!
    
    var arr_AllFavProduct: [Res_FavProduct] = []
    var arr_FavProvider: [Res_FavProvider] = []
    
    var type = "Restaurant"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fav_TableView.register(UINib(nibName: "FavCell", bundle: nil), forCellReuseIdentifier: "FavCell")
        self.fav_TableView.register(UINib(nibName: "AllResCell", bundle: nil), forCellReuseIdentifier: "AllResCell")
        btn_RestOt.backgroundColor = R.color.main()
        btn_RestOt.setTitleColor(.white, for: .normal)
        btn_ItemOt.backgroundColor = .clear
        btn_ItemOt.setTitleColor(.black, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        WebGetFavProvider()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func btn_Rest(_ sender: UIButton) {
        btn_RestOt.backgroundColor = R.color.main()
        btn_RestOt.setTitleColor(.white, for: .normal)
        btn_ItemOt.backgroundColor = .clear
        btn_ItemOt.setTitleColor(.black, for: .normal)
        type = "Restaurant"
        WebGetFavProvider()
    }
    
    @IBAction func btn_Items(_ sender: UIButton) {
        btn_RestOt.backgroundColor = .clear
        btn_RestOt.setTitleColor(.black, for: .normal)
        btn_ItemOt.backgroundColor = R.color.main()
        btn_ItemOt.setTitleColor(.white, for: .normal)
        type = "Item"
        WebGetFavProduct()
    }
}

extension FavouriteVC
{
    
    func WebGetFavProduct()
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        paramDict["token"] = k.emptyString as AnyObject
        paramDict["cat_id"] = k.emptyString as AnyObject
        paramDict["rest_id"] = k.emptyString as AnyObject
        paramDict["size"] = k.emptyString as AnyObject
        paramDict["type"] = type as AnyObject
        paramDict["lat"] = k.emptyString as AnyObject
        paramDict["lon"] = k.emptyString as AnyObject
        
        print(paramDict)
        
        Api.shared.fav_Products(self, paramDict) { responseData in
            let obj = responseData
            if obj.status == "1" {
                if let obj_Res = obj.result {
                    if obj_Res.count > 0 {
                        self.arr_AllFavProduct = obj_Res
                        self.fav_TableView.backgroundView = UIView()
                        self.fav_TableView.reloadData()
                    }
                }
            }  else {
                self.arr_AllFavProduct = []
                self.fav_TableView.backgroundView = UIView()
                self.fav_TableView.reloadData()
                Utility.noDataFound("You have no orders".localiz(), tableViewOt: self.fav_TableView, parentViewController: self)
            }
            self.fav_TableView.reloadData()
        }
    }
    
    func WebGetFavProvider()
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        paramDict["token"] = k.emptyString as AnyObject
        paramDict["cat_id"] = k.emptyString as AnyObject
        paramDict["rest_id"] = k.emptyString as AnyObject
        paramDict["size"] = k.emptyString as AnyObject
        paramDict["type"] = type as AnyObject
        paramDict["lat"] = k.emptyString as AnyObject
        paramDict["lon"] = k.emptyString as AnyObject
        
        print(paramDict)
        
        Api.shared.fav_Providers(self, paramDict) { responseData in
            let obj = responseData
            if obj.status == "1" {
                if let obj_Res = obj.result {
                    if obj_Res.count > 0 {
                        self.arr_FavProvider = obj_Res
                        self.fav_TableView.backgroundView = UIView()
                        self.fav_TableView.reloadData()
                    }
                }
            }  else {
                self.arr_FavProvider = []
                self.fav_TableView.backgroundView = UIView()
                self.fav_TableView.reloadData()
                Utility.noDataFound("You have no orders".localiz(), tableViewOt: self.fav_TableView, parentViewController: self)
            }
            self.fav_TableView.reloadData()
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
                self.WebGetFavProvider()
            }
        }
    }
}

extension FavouriteVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if type == "Restaurant" {
            return self.arr_FavProvider.count
        } else {
            return self.arr_AllFavProduct.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if type == "Item" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavCell", for: indexPath) as! FavCell
            cell.showAnimatedSkeleton()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let obj = self.arr_AllFavProduct[indexPath.row]
                cell.lbl_ItemName.text = obj.item_name ?? ""
                cell.lbl_ItemPrice.text = "$\(obj.item_price ?? "")"
                cell.lbl_ItemOfferPrice.text = "$\(obj.offer_item_price ?? "")"
                cell.lbl_ResName.text = obj.rest_details?.provider_name ?? ""
                cell.lbl_ItemLeft.text = "\(obj.item_quantity ?? "") \("left".localiz())"
                
                if Router.BASE_IMAGE_URL != obj.rest_details?.image {
                    Utility.setImageWithSDWebImage(obj.rest_details?.image ?? "", cell.item_Img)
                } else {
                    cell.item_Img.image = R.image.placeholder()
                }
                cell.hideSkeleton()
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AllResCell", for: indexPath) as! AllResCell
            cell.showAnimatedSkeleton()
            let obj = self.arr_FavProvider[indexPath.row]
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                cell.lbl_ResName.text = obj.provider_name ?? ""
                cell.lbl_Address.text = obj.provider_streat_address ?? ""
                cell.lbl_Distance.text = "\(obj.distance ?? "") \("Km".localiz())"
                cell.lbl_ItemAndBags.text = "\(obj.item_left_quantity ?? "") \("ITEMS left".localiz())\n\(obj.magic_food_left_quantity ?? "") \("Mystery Mix left".localiz())"
                
                if Router.BASE_IMAGE_URL != obj.image {
                    Utility.setImageWithSDWebImage(obj.image ?? "", cell.item_Image)
                } else {
                    cell.item_Image.image = R.image.placeholder()
                }
                cell.hideSkeleton()
            }
            
            cell.clo_Fav = {() in
                self.AddFavProvider(provider_Id: obj.id ?? "")
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if type == "Item" {
            return 280
        } else {
           return UITableView.automaticDimension
        }
    }
}

extension FavouriteVC: SkeletonTableViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "FavCell"
    }
}
