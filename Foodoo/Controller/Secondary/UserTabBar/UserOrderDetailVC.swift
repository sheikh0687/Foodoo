//
//  UserOrderDetailVC.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 08/04/24.
//

import UIKit
import MapKit

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
    @IBOutlet weak var lbl_ItemCount: UILabel!
    @IBOutlet weak var lbl_TotalAmountDt: UILabel!
    @IBOutlet weak var map_View: MKMapView!
    
    var product_Id = ""
    var provider_Id = ""
    
    var total_Amount = 0
    var offer_ItemPrice = 0
    
    var cat_Id:String!
    var cat_Name:String!
    var product_Name:String!
    var product_Price:String!
    var item_Qty:String!
    var extra_ItemTtlPrice:Int = 0
    
    var arr_AdditionalItems: [Product_additional] = []
    var arr_ProductImg: [Product_images] = []
    var arr_ProviderReview: [Res_Reviews] = []
    
    var extraItem_Id: [Int] = []
    var extraItem_Name: [String] = []
    var extraItem_Price: [Int] = []
    
    var itemCount:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.extraItem_TableView.register(UINib(nibName: "ExtraItemCell", bundle: nil), forCellReuseIdentifier: "ExtraItemCell")
        self.review_TableView.register(UINib(nibName: "AllReviewCell", bundle: nil), forCellReuseIdentifier: "AllReviewCell")
        self.img_CollectionView.register(UINib(nibName: "ImgCell", bundle: nil), forCellWithReuseIdentifier: "ImgCell")
        self.view_TotalAddedItem.isHidden = true
        itemCount = Int(self.lbl_ItemCount.text ?? "") ?? 0
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
    
    @IBAction func btn_AddToCart(_ sender: UIButton) {
        AddProducts()
    }
    
    @IBAction func btn_Plus(_ sender: UIButton) {
        itemCount += 1
        self.lbl_ItemCount.text = String(itemCount)
        self.view_TotalAddedItem.isHidden = false
        total_Amount += offer_ItemPrice
        print(total_Amount)
        self.lbl_TotalAmountDt.text = "$\(total_Amount).00 for \(itemCount ?? 0) \("ITEMS".localiz())"
    }
    
    @IBAction func btn_Minus(_ sender: UIButton) {
        if itemCount != 1 {
            itemCount -= 1
            self.lbl_ItemCount.text = String(itemCount)
            total_Amount -= offer_ItemPrice
            print(total_Amount)
            self.lbl_TotalAmountDt.text = "$\(total_Amount).00 for \(itemCount ?? 0) \("ITEMS".localiz())"
        } else {
            print("No need to minus")
        }
    }
}

// MARK: Api
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
            self.lbl_ItemPrice.text = "$\(obj.offer_item_price ?? "")"
            self.lbl_ProviderName.text = obj.rest_details?.provider_name ?? ""
            self.lbl_Quantity.text = "\(obj.item_quantity ?? "") \("left".localiz())"
            self.lbl_ItemDescription.text = obj.item_description ?? ""
            self.offer_ItemPrice = Int(obj.offer_item_price ?? "") ?? 0
            self.total_Amount = Int(obj.offer_item_price ?? "") ?? 0
            
            self.lbl_AboutItem.text = obj.rest_details?.description ?? ""
            self.lbl_Mobile.text = obj.rest_details?.provider_mobile ?? ""
            self.lbl_Address.text = obj.rest_details?.provider_streat_address ?? ""
            
            self.cat_Id = obj.cat_id ?? ""
            self.cat_Name = obj.cat_name ?? ""
            self.product_Name = obj.item_name ?? ""
            self.product_Price = obj.item_price ?? ""
            self.item_Qty = obj.item_quantity ?? ""
            
            let coordinate1 = CLLocationCoordinate2D(latitude: Double(obj.rest_details?.lat ?? "") ?? 0.0, longitude: Double(obj.rest_details?.lon ?? "") ?? 0.0)

            let annotation1 = CustomPointAnnotation()
            annotation1.coordinate = coordinate1
            annotation1.imageName = ""
            self.map_View.addAnnotation(annotation1)
            
            Utility.zoomMapToAnnotations(self.map_View)
            
            if let obj_AdditionalItm = obj.product_additional {
                if obj_AdditionalItm.count > 0 {
                    self.arr_AdditionalItems = obj_AdditionalItm
                    self.extraItem_TableHeight.constant = CGFloat(obj_AdditionalItm.count * 70)
                } else {
                    self.arr_AdditionalItems = []
                    self.extraItem_TableHeight.constant = CGFloat(obj_AdditionalItm.count * 70 - 1)
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
                self.btn_LikesOt.setImage(UIImage(named: "HeartFilled"), for: .normal)
            } else {
                self.btn_LikesOt.setImage(UIImage(named: "HeartUnfilled"), for: .normal)
            }
        }
    }
    
    func GetReviews()
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["provider_id"] = provider_Id as AnyObject
        
        print(paramDict)
        
        Api.shared.provider_Reviews(self, paramDict) { responseData in
            let obj = responseData
            if obj.status == "1" {
                if let obj_Result = obj.result {
                    if obj_Result.count > 0 {
                        self.arr_ProviderReview = obj_Result
                        self.review_TableHeight.constant = CGFloat(obj_Result.count * 140)
                    } else {
                        self.arr_ProviderReview = []
                    }
                    self.review_TableView.reloadData()
                }
            } else {
                self.review_TableHeight.constant = 0
            }
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
    
    func AddProducts()
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["product_id"] = product_Id as AnyObject
        paramDict["cat_id"] = cat_Id as AnyObject
        paramDict["cat_name"] = cat_Name as AnyObject
        paramDict["product_name"] = product_Name as AnyObject
        paramDict["product_price"] = product_Price as AnyObject
        paramDict["provider_id"] = provider_Id as AnyObject
        paramDict["total_amount"] = product_Price as AnyObject
        paramDict["before_discount_amount"] = product_Price as AnyObject
        paramDict["extra_item_id"] = extraItem_Id.map{ String($0)}.joined(separator: ",") as AnyObject
        paramDict["extra_item_name"] = extraItem_Name.joined(separator: ",") as AnyObject
        paramDict["extra_item_price"] = extraItem_Price.map{ String($0)}.joined(separator: ",") as AnyObject
        paramDict["extra_item_qty"] = "" as AnyObject
        paramDict["total_extra_item_price"] = String(extra_ItemTtlPrice) as AnyObject
        paramDict["quantity"] = item_Qty as AnyObject
        
        print(paramDict)
        
        Api.shared.addTo_Cart(self, paramDict) { responseData in
            if responseData.status == "1" {
                let vc = R.storyboard.main().instantiateViewController(withIdentifier: "PresentPopVC") as! PresentPopVC
                
                vc.cloGoToCart = {() in
                    let vc = R.storyboard.main().instantiateViewController(withIdentifier: "MyCartVC") as! MyCartVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
            } else {
                debugPrint("Something Went Wrong")
            }
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
            
            if Router.BASE_IMAGE_URL != obj.extra_item_image {
                Utility.setImageWithSDWebImage(obj.extra_item_image ?? "", cell.img)
            } else {
                cell.img.image = R.image.placeholder()
            }
            
            cell.imgCheck.image = extraItem_Id.contains(indexPath.row) ? R.image.rectangleChecked() : R.image.rectangleUncheck()
                        
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
            return 70
        } else {
            return 140
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if extraItem_Id.contains(indexPath.row) {
            if let index = extraItem_Id.firstIndex(of: indexPath.row) {
                extraItem_Id.remove(at: index)
                extraItem_Name.remove(at: index)
                extraItem_Price.remove(at: index)
                if self.arr_AdditionalItems.count > 0 {
                    let obj = self.arr_AdditionalItems[indexPath.row]
                    total_Amount -= (Int(obj.item_price ?? "") ?? 0)
                    self.lbl_TotalAmountDt.text = "$\(total_Amount).00 for \(itemCount ?? 0) \("ITEMS".localiz())"
                    if extraItem_Price.count > 0 {
                        extra_ItemTtlPrice = extraItem_Price.reduce(0, -)
                    } else {
                        extra_ItemTtlPrice = 0
                    }
                }
            }
        } else {
            if self.arr_AdditionalItems.count > 0 {
                let obj = self.arr_AdditionalItems[indexPath.row]
                extraItem_Id.append(indexPath.row)
                extraItem_Name.append(obj.item_name ?? "")
                extraItem_Price.append(Int(obj.item_price ?? "") ?? 0)
                total_Amount += (Int(obj.item_price ?? "") ?? 0)
                self.lbl_TotalAmountDt.text = "$\(total_Amount).00 for \(itemCount ?? 0) \("ITEMS".localiz())"
                if extraItem_Price.count > 0 {
                    extra_ItemTtlPrice = extraItem_Price.reduce(0, +)
                } else {
                    extra_ItemTtlPrice = 0
                }
                view_TotalAddedItem.isHidden = false
            }
        }
        tableView.reloadRows(at: [indexPath], with: .none)
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
