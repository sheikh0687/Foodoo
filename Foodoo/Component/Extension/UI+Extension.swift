//
//  UI+Extension.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 01/05/24.
//

import Foundation

extension UserHomeVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func registerAllCollection()
    {
        self.shop_CollectionView.register(UINib(nibName: "ShopCategoryCell", bundle: nil), forCellWithReuseIdentifier: "ShopCategoryCell")
        self.rest_CollectionView.register(UINib(nibName: "RestaurantCell", bundle: nil), forCellWithReuseIdentifier: "RestaurantCell")
        self.mysteryMix_CollectionVw.register(UINib(nibName: "BagAndFoodCell", bundle: nil), forCellWithReuseIdentifier: "BagAndFoodCell")
        self.dailyDeal_CollectionVw.register(UINib(nibName: "BagAndFoodCell", bundle: nil), forCellWithReuseIdentifier: "BagAndFoodCell")
        self.newOnBoard_CollectionVw.register(UINib(nibName: "RestaurantCell", bundle: nil), forCellWithReuseIdentifier: "RestaurantCell")
        self.recommendRes_CollectionVw.register(UINib(nibName: "RestaurantCell", bundle: nil), forCellWithReuseIdentifier: "RestaurantCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == shop_CollectionView {
            return self.arr_ShopCategory.count
        } else if collectionView == rest_CollectionView || collectionView == newOnBoard_CollectionVw || collectionView == recommendRes_CollectionVw {
            return self.arr_AllResList.count
        } else if collectionView == mysteryMix_CollectionVw {
            return self.arr_MysteryMix.count
        } else {
            return self.arr_DailyDeal.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == shop_CollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCategoryCell", for: indexPath) as! ShopCategoryCell
            cell.showAnimatedSkeleton()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let obj = self.arr_ShopCategory[indexPath.row]
                cell.lbl_ItemName.text = obj.category_name ?? ""
                self.category_Id = obj.id ?? ""
                
                if Router.BASE_IMAGE_URL != obj.image {
                    Utility.setImageWithSDWebImage(obj.image ?? "", cell.item_Img)
                } else {
                    cell.item_Img.image = R.image.placeholder()
                }
                cell.hideSkeleton()
            }
            return cell
        } else if collectionView == rest_CollectionView || collectionView == newOnBoard_CollectionVw || collectionView == recommendRes_CollectionVw {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantCell", for: indexPath) as! RestaurantCell
            cell.showAnimatedSkeleton()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let obj = self.arr_AllResList[indexPath.row]
                cell.lbl_ItemName.text = obj.provider_name ?? ""
                cell.lbl_Address.text = obj.provider_streat_address ?? ""
                cell.lbl_ItemAndBags.text = "\(obj.item_left_quantity ?? "") \("ITEMS left".localiz())\n\(obj.magic_food_left_quantity ?? "") \("Mystery Mix left".localiz())"
                cell.lbl_Distance.text = "\(obj.distance ?? "") \("Km".localiz())"
                
                if Router.BASE_IMAGE_URL != obj.provider_logo {
                    Utility.setImageWithSDWebImage(obj.provider_logo ?? "", cell.item_Img)
                } else {
                    cell.item_Img.image = R.image.placeholder()
                }
                
                switch obj.fav_provider {
                case "YES":
                    cell.btn_FavOt.setImage(UIImage(named: "mdi_heart"), for: .normal)
                default:
                    cell.btn_FavOt.setImage(UIImage(named: "mdi_heart-outline"), for: .normal)
                }
                
                cell.clo_Fav = { () in
                    self.AddFavProvider(provider_Id: obj.id ?? "")
                }
                
                cell.hideSkeleton()
            }
            return cell
        } else if collectionView == mysteryMix_CollectionVw {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BagAndFoodCell", for: indexPath) as! BagAndFoodCell
            cell.showAnimatedSkeleton()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let obj = self.arr_MysteryMix[indexPath.row]
                cell.lbl_ItemQuantity.text = "\(obj.item_quantity ?? "") \("left".localiz())"
                cell.lbl_ItemName.text = obj.item_name ?? ""
                cell.lbl_ItemOfferPrice.text = "$\(obj.offer_item_price ?? "")"
                cell.lbl_ItemPrice.text = "$\(obj.item_price ?? "")"
                cell.lbl_ProviderName.text = obj.rest_details?.provider_name ?? ""
                cell.lbl_Distance.text = "\(obj.rest_details?.distance ?? "") \("Km".localiz())"
                cell.hideSkeleton()
                cell.arr_ProductImg = obj.product_images ?? []
                cell.collection_Img.reloadData()
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BagAndFoodCell", for: indexPath) as! BagAndFoodCell
            cell.showAnimatedSkeleton()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let obj = self.arr_DailyDeal[indexPath.row]
                cell.lbl_ItemQuantity.text = "\(obj.item_quantity ?? "") \("left".localiz())"
                cell.lbl_ItemName.text = obj.item_name ?? ""
                cell.lbl_ItemOfferPrice.text = "$\(obj.offer_item_price ?? "")"
                cell.lbl_ItemPrice.text = "$\(obj.item_price ?? "")"
                cell.lbl_ProviderName.text = obj.rest_details?.provider_name ?? ""
                cell.lbl_Distance.text = "\(obj.rest_details?.distance ?? "") \("Km".localiz())"
                cell.hideSkeleton()
                cell.arr_ProductImg = obj.product_images ?? []
                cell.collection_Img.reloadData()
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == shop_CollectionView {
            return CGSize(width: 140, height: collectionView.frame.height)
        } else if collectionView == rest_CollectionView || collectionView == newOnBoard_CollectionVw || collectionView == recommendRes_CollectionVw {
            return CGSize(width: 240, height: collectionView.frame.height)
        } else if collectionView == mysteryMix_CollectionVw {
            return CGSize(width: 220, height: collectionView.frame.height)
        } else {
            return CGSize(width: 220, height: collectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == shop_CollectionView {
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResSeeAllVC") as! ResSeeAllVC
            vc.is_From = "ShopCategory"
            vc.cat_Id = self.arr_ShopCategory[indexPath.row].id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        } else if collectionView == rest_CollectionView || collectionView == newOnBoard_CollectionVw || collectionView == recommendRes_CollectionVw {
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ResMenuVC") as! ResMenuVC
            self.navigationController?.pushViewController(vc, animated: true)
        } else if collectionView == mysteryMix_CollectionVw {
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "UserOrderDetailVC") as! UserOrderDetailVC
            vc.product_Id = self.arr_MysteryMix[indexPath.row].id ?? ""
            vc.provider_Id = self.arr_MysteryMix[indexPath.row].provider_id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "UserOrderDetailVC") as! UserOrderDetailVC
            vc.product_Id = self.arr_DailyDeal[indexPath.row].id ?? ""
            vc.provider_Id = self.arr_DailyDeal[indexPath.row].provider_id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ResSeeAllVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if is_From == "ShopCategory" {
            return self.arr_ResCategories.count
        } else if is_From == "Res" {
            return self.arr_ResCategories.count
        } else if is_From == "Review" {
            return self.arr_RatingReview.count
        } else {
            return self.arr_FilterProduct.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if is_From == "ShopCategory" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AllResCell", for: indexPath) as! AllResCell
            
            let obj = self.arr_ResCategories[indexPath.row]
            cell.view_FavButton.isHidden = true
            
            cell.lbl_ResName.text = obj.provider_name ?? ""
            cell.lbl_Address.text = obj.provider_streat_address ?? ""
            cell.lbl_ItemAndBags.text = "\(obj.item_left_quantity ?? "") \("ITEMS left".localiz())\n\(obj.magic_food_left_quantity ?? "")  \("Mystery Mix left".localiz())"
            cell.view_Rating.rating = Double("\(Double(obj.avg_rating ?? "") ?? 0.0) \(obj.total_rating_count ?? "")") ?? 0.0
            cell.lbl_Distance.text = "\(obj.distance ?? "") \("Km".localiz())"
            
            cell.cloMenu = {() in
                let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ResMenuVC") as! ResMenuVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            if Router.BASE_IMAGE_URL != obj.provider_logo {
                Utility.setImageWithSDWebImage(obj.provider_logo ?? "", cell.item_Image)
            } else {
                cell.item_Image.image = R.image.placeholder()
            }
            
            return cell
        } else if is_From == "Res" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AllResCell", for: indexPath) as! AllResCell
            let obj = self.arr_ResCategories[indexPath.row]
            cell.view_FavButton.isHidden = true
            
            cell.lbl_ResName.text = obj.provider_name ?? ""
            cell.lbl_Address.text = obj.provider_streat_address ?? ""
            cell.lbl_ItemAndBags.text = "\(obj.item_left_quantity ?? "") \("ITEMS left".localiz())\n\(obj.magic_food_left_quantity ?? "") \("Mystery Mix left".localiz())"
            cell.view_Rating.rating = Double("\(Double(obj.avg_rating ?? "") ?? 0.0) \(obj.total_rating_count ?? "")") ?? 0.0
            cell.lbl_Distance.text = "\(obj.distance ?? "") \("Km".localiz())"
            
            if Router.BASE_IMAGE_URL != obj.provider_logo {
                Utility.setImageWithSDWebImage(obj.provider_logo ?? "", cell.item_Image)
            } else {
                cell.item_Image.image = R.image.placeholder()
            }
            
            cell.cloMenu = {() in
                let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ResMenuVC") as! ResMenuVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        } else if is_From == "Review" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AllReviewCell", for: indexPath) as! AllReviewCell
            let obj = self.arr_RatingReview[indexPath.row]
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
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavCell", for: indexPath) as! FavCell
            cell.showAnimatedSkeleton()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let obj = self.arr_FilterProduct[indexPath.row]
//                cell.lbl.text = "\(obj.item_quantity ?? "") left"
                cell.view_FavUnfav.isHidden = true
                cell.lbl_ItemName.text = obj.item_name ?? ""
                cell.lbl_ItemPrice.text = "$\(obj.item_price ?? "")"
                cell.lbl_ResName.text = obj.rest_details?.provider_name ?? ""
                cell.hideSkeleton()
                cell.arr_ProductImg = obj.product_images ?? []
                cell.collection_Img.reloadData()
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if is_From == "Magic" || is_From == "Discount" {
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserOrderDetailVC") as! UserOrderDetailVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if is_From == "ShopCategory" {
            let obj = self.arr_ResCategories[indexPath.row]
            if obj.provider_streat_address != "" {
                return UITableView.automaticDimension
            } else {
                return 180
            }
        } else if is_From == "Res" {
          let obj = self.arr_ResCategories[indexPath.row]
            if obj.provider_streat_address != "" {
                return UITableView.automaticDimension
            } else {
                return 165
            }
        } else {
            return UITableView.automaticDimension
        }
    }
}
