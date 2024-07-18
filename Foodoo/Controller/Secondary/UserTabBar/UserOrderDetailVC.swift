//
//  UserOrderDetailVC.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 08/04/24.
//

import UIKit

class UserOrderDetailVC: UIViewController {

    @IBOutlet weak var extraItem_TableView: UITableView!
    @IBOutlet weak var extraItem_TableHeight: NSLayoutConstraint!
    @IBOutlet weak var img_CollectionView: UICollectionView!
    @IBOutlet weak var review_TableView: UITableView!
    @IBOutlet weak var review_TableHeight: NSLayoutConstraint!
    
    @IBOutlet weak var btn_LikesOt: UIButton!
    
    @IBOutlet weak var lbl_ItemName: UILabel!
    @IBOutlet weak var lbl_ItemPrice: UILabel!
    @IBOutlet weak var lbl_ProviderName: UILabel!
    @IBOutlet weak var lbl_Quantity: UILabel!
    @IBOutlet weak var lbl_Time: UILabel!
    @IBOutlet weak var lbl_Distance: UILabel!
    @IBOutlet weak var lbl_ItemDescription: UILabel!
    @IBOutlet weak var lbl_AboutItem: UILabel!
    @IBOutlet weak var lbl_Mobile: UILabel!
    @IBOutlet weak var lbl_Address: UILabel!
    @IBOutlet weak var view_TotalAddedItem: UIView!
    
    var product_Id = ""
    var provider_Id = ""
    
    var arr_AdditionalItems: [Product_additional] = []
    var arr_ProductImg: [Product_images] = []
    var arr_ProviderReview: [Res_Reviews] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.extraItem_TableView.register(UINib(nibName: "ExtraItemCell", bundle: nil), forCellReuseIdentifier: "ExtraItemCell")
        self.review_TableView.register(UINib(nibName: "AllReviewCell", bundle: nil), forCellReuseIdentifier: "AllReviewCell")
        self.img_CollectionView.register(UINib(nibName: "ImgCell", bundle: nil), forCellWithReuseIdentifier: "ImgCell")
        self.view_TotalAddedItem.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        GetProductDetails()
        GetReviews()
    }
    
    @IBAction func btn_SeeAll(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResSeeAllVC") as! ResSeeAllVC
        vc.is_From = "Review"
        vc.arr_RatingReview = self.arr_ProviderReview
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_Cart(_ sender: UIButton) {
        
    }
    
    @IBAction func btn_Likes(_ sender: UIButton) {
        LikeAndUnlikes()
    }
}

extension UserOrderDetailVC {
    
    func GetProductDetails()
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["product_id"] = product_Id as AnyObject
        
        print(paramDict)
        
        Api.shared.products_Detail(self, paramDict) { responseData in
            let obj = responseData
            self.lbl_ItemName.text = obj.item_name ?? ""
            self.lbl_ItemPrice.text = "$\(obj.item_price ?? "")"
            self.lbl_ProviderName.text = obj.rest_details?.provider_name ?? ""
            self.lbl_Quantity.text = "\(obj.item_quantity ?? "") left"
            self.lbl_ItemDescription.text = obj.item_description ?? ""
            
            self.lbl_AboutItem.text = obj.rest_details?.description ?? ""
            self.lbl_Mobile.text = obj.rest_details?.provider_mobile ?? ""
            self.lbl_Address.text = obj.rest_details?.provider_streat_address ?? ""
            
            if let obj_AdditionalItm = obj.product_additional {
                if obj_AdditionalItm.count > 0 {
                    self.arr_AdditionalItems = obj_AdditionalItm
                    self.extraItem_TableHeight.constant = CGFloat(obj_AdditionalItm.count * 45)
                } else {
                    self.arr_AdditionalItems = []
                    self.extraItem_TableHeight.constant = CGFloat(obj_AdditionalItm.count * 45 - 1)
                }
                self.extraItem_TableView.reloadData()
            }
            
            if let obj_ProductImg = obj.product_images {
                if obj_ProductImg.count > 0 {
                    self.arr_ProductImg = obj_ProductImg
                } else {
                    self.arr_ProductImg = []
                }
                self.img_CollectionView.reloadData()
            }
            
            if obj.like_status == "Yes" {
                self.btn_LikesOt.setImage(UIImage(systemName: ""), for: <#T##UIControl.State#>)
            } else {
                
            }
        }
    }
    
    func GetReviews()
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["provider_id"] = provider_Id as AnyObject
        
        print(paramDict)
        
        Api.shared.provider_Reviews(self, paramDict) { responseData in
            if responseData.count > 0 {
                self.arr_ProviderReview = responseData
                self.review_TableHeight.constant = CGFloat(responseData.count * 140)
            } else {
                self.arr_ProviderReview = []
            }
            self.review_TableView.reloadData()
        }
    }
    
    func LikeAndUnlikes()
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["product_id"] = product_Id as AnyObject
        
        print(paramDict)
        
        Api.shared.likeAndUnlike_Product(self, paramDict) { responseData in
            self.GetProductDetails()
        }
    }
}

extension UserOrderDetailVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == extraItem_TableView {
            return self.arr_AdditionalItems.count
        } else {
            return self.arr_ProviderReview.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == extraItem_TableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExtraItemCell", for: indexPath) as! ExtraItemCell
            let obj = self.arr_AdditionalItems[indexPath.row]
            cell.lbl_ExtraItmName.text = obj.item_name ?? ""
            cell.lbl_ExtraItmPrice.text = "$\(obj.item_price ?? "")"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AllReviewCell", for: indexPath) as! AllReviewCell
            let obj = arr_ProviderReview[indexPath.row]
            cell.lbl_ProviderName.text = obj.user_name ?? ""
            cell.lbl_Review.text = obj.review ?? ""
            cell.view_Cosmos.rating = Double(obj.rating ?? "") ?? 0.0
            cell.lbl_Ratings.text = obj.rating ?? ""
            cell.lbl_DateTime.text = obj.date_time ?? ""
            
            if Router.BASE_IMAGE_URL != obj.image {
                Utility.setImageWithSDWebImage(obj.image ?? "", cell.img_Profile)
            } else {
                cell.img_Profile.image = R.image.placeholder()
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == extraItem_TableView {
            return 45
        } else {
            return 140
        }
    }
}

extension UserOrderDetailVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arr_ProductImg.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImgCell", for: indexPath) as! ImgCell
        let obj = self.arr_ProductImg[indexPath.row]
        if Router.BASE_IMAGE_URL != obj.image {
            Utility.setImageWithSDWebImage(obj.image ?? "", cell.img)
        } else {
            cell.img.image = R.image.placeholder()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
