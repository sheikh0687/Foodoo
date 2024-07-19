//
//  BagAndFoodCell.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 03/04/24.
//

import UIKit
import LanguageManager_iOS

class BagAndFoodCell: UICollectionViewCell {

    @IBOutlet weak var collection_Img: UICollectionView!
    @IBOutlet weak var lbl_ResTime: UILabel!
    @IBOutlet weak var lbl_ItemName: UILabel!
    @IBOutlet weak var lbl_ItemOfferPrice: UILabel!
    @IBOutlet weak var lbl_ItemPrice: UILabel!
    @IBOutlet weak var lbl_ProviderName: UILabel!
    @IBOutlet weak var lbl_ItemQuantity: UILabel!
    @IBOutlet weak var lbl_Distance: UILabel!
    @IBOutlet weak var view_TimeNDate: UIView!
    @IBOutlet weak var sub_View: UIView!
    
    var arr_ProductImg: [Product_images] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collection_Img.register(UINib(nibName: "ImgCell", bundle: nil),forCellWithReuseIdentifier: "ImgCell")
        collection_Img.dataSource = self
        collection_Img.delegate = self
        if LanguageManager.shared.currentLanguage == .ar {
            view_TimeNDate.clipsToBounds = true
            view_TimeNDate.layer.cornerRadius = 10
            view_TimeNDate.layer.maskedCorners = [.layerMinXMinYCorner]
        } else {
            view_TimeNDate.clipsToBounds = true
            view_TimeNDate.layer.cornerRadius = 10
            view_TimeNDate.layer.maskedCorners = [ .layerMaxXMinYCorner]
        }
        sub_View.clipsToBounds = true
        sub_View.layer.cornerRadius = 10
        sub_View.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
    }
}

extension BagAndFoodCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
