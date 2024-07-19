//
//  WalletTransactionCell.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 10/04/24.
//

import UIKit

class WalletTransactionCell: UITableViewCell {

    @IBOutlet weak var lbl_WalletAmount: UILabel!
    @IBOutlet weak var lbl_DateTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
