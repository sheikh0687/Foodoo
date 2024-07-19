//
//  ItemsCell.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 03/05/24.
//

import UIKit

class ItemsCell: UITableViewCell {

    @IBOutlet weak var lbl_ItemName: UILabel!
    @IBOutlet weak var lbl_Amount: UILabel!
    @IBOutlet weak var lbl_ExtraItem: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
