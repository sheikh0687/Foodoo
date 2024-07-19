//
//  FavCell.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 04/04/24.
//

import UIKit
import LanguageManager_iOS

class FavCell: UITableViewCell {

    @IBOutlet weak var item_Img: UIImageView!
    @IBOutlet weak var lbl_ItemLeft: UILabel!
    @IBOutlet weak var lbl_ResTime: UILabel!
    @IBOutlet weak var lbl_ItemName: UILabel!
    @IBOutlet weak var lbl_ItemPrice: UILabel!
    @IBOutlet weak var lbl_ItemOfferPrice: UILabel!
    @IBOutlet weak var lbl_ResName: UILabel!
    @IBOutlet weak var lbl_ResDistance: UILabel!
    @IBOutlet weak var view_Quantity: UIView!
    @IBOutlet weak var view_ResTime: UIView!
    @IBOutlet weak var view_Main: UIView!
    @IBOutlet weak var view_SubMain: UIView!
    @IBOutlet weak var collection_Img: UICollectionView!
    @IBOutlet weak var view_FavUnfav: UIView!
    
    var arr_ProductImg: [Product_images] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collection_Img.register(UINib(nibName: "ImgCell", bundle: nil),forCellWithReuseIdentifier: "ImgCell")
        collection_Img.dataSource = self
        collection_Img.delegate = self
        
        view_SubMain.clipsToBounds = true
        view_SubMain.layer.cornerRadius = 10
        view_SubMain.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        if LanguageManager.shared.currentLanguage == .ar {
            view_ResTime.clipsToBounds = true
            view_ResTime.layer.cornerRadius = 10
            view_ResTime.layer.maskedCorners = [.layerMinXMinYCorner]
        } else {
            view_ResTime.clipsToBounds = true
            view_ResTime.layer.cornerRadius = 10
            view_ResTime.layer.maskedCorners = [ .layerMaxXMinYCorner]
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }    
    
    @IBAction func btn_Fav(_ sender: UIButton) {
        
    }
}

extension FavCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
