//
//  AllReviewCell.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 08/04/24.
//

import UIKit
import Cosmos

class AllReviewCell: UITableViewCell {

    @IBOutlet weak var img_Profile: UIImageView!
    @IBOutlet weak var lbl_ProviderName: UILabel!
    @IBOutlet weak var lbl_DateTime: UILabel!
    @IBOutlet weak var view_Cosmos: CosmosView!
    @IBOutlet weak var lbl_Ratings: UILabel!
    @IBOutlet weak var lbl_Review: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
