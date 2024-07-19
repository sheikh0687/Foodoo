//
//  AllResCell.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 06/04/24.
//

import UIKit
import Cosmos

class AllResCell: UITableViewCell {

    @IBOutlet weak var lbl_ResName: UILabel!
    @IBOutlet weak var lbl_ItemName: UILabel!
    @IBOutlet weak var view_Rating: CosmosView!
    @IBOutlet weak var view_Address: UIView!
    @IBOutlet weak var btn_ViewOt: UIButton!
    @IBOutlet weak var lbl_Address: UILabel!
    @IBOutlet weak var item_Image: UIImageView!
    @IBOutlet weak var lbl_ItemAndBags: UILabel!
    @IBOutlet weak var btn_FavOt: UIButton!
    @IBOutlet weak var lbl_Distance: UILabel!
    @IBOutlet weak var view_FavButton: UIView!
    
    var cloMenu: (() -> Void)?
    var clo_Fav: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btn_Fav(_ sender: UIButton) {
        self.clo_Fav?()
    }
    
    @IBAction func btn_ViewMenu(_ sender: UIButton) {
        self.cloMenu?()
    }
}
