//
//  RestaurantCell.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 03/04/24.
//

import UIKit

class RestaurantCell: UICollectionViewCell {

    @IBOutlet weak var item_Img: UIImageView!
    @IBOutlet weak var lbl_ItemName: UILabel!
    @IBOutlet weak var lbl_Address: UILabel!
    @IBOutlet weak var lbl_Time: UILabel!
    @IBOutlet weak var lbl_Distance: UILabel!
    @IBOutlet weak var lbl_ItemAndBags: UILabel!
    @IBOutlet weak var btn_FavOt: UIButton!
    
    var clo_Fav:(() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        item_Img.clipsToBounds = true
        item_Img.layer.cornerRadius = 10
        item_Img.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    @IBAction func btn_Fav(_ sender: UIButton) {
        clo_Fav?()
    }
}
