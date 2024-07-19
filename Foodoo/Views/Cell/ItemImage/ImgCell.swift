//
//  ImgCell.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 29/04/24.
//

import UIKit

class ImgCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        img.clipsToBounds = true
        img.layer.cornerRadius = 10
        img.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

}
