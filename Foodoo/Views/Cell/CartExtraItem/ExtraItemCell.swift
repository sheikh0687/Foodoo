//
//  ExtraItemCell.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 08/04/24.
//

import UIKit

class ExtraItemCell: UITableViewCell {

    @IBOutlet weak var lbl_ExtraItmName: UILabel!
    @IBOutlet weak var lbl_ExtraItmPrice: UILabel!
    @IBOutlet weak var imgCheck: UIImageView!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
