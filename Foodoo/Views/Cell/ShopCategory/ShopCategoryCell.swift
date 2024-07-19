//
//  ShopCategoryCell.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 03/04/24.
//

import UIKit

class ShopCategoryCell: UICollectionViewCell {

    @IBOutlet weak var lbl_ItemName: UILabel!
    @IBOutlet weak var item_Img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        item_Img.clipsToBounds = true
        item_Img.layer.cornerRadius = 10
        item_Img.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
}
