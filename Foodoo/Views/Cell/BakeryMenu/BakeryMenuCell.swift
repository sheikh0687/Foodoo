//
//  BakeryMenuCell.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 30/04/24.
//

import UIKit
import LanguageManager_iOS

class BakeryMenuCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl_ItemName: UILabel!
    @IBOutlet weak var lbl_ProviderName: UILabel!
    @IBOutlet weak var lbl_ItemPrice: UILabel!
    
    var cloViewDetail:(() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if LanguageManager.shared.currentLanguage == .ar {
            img.clipsToBounds = true
            img.layer.cornerRadius = 10
            img.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        } else {
            img.clipsToBounds = true
            img.layer.cornerRadius = 10
            img.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func btn_ViewDetail(_ sender: UIButton) {
        self.cloViewDetail?()
    }
}
