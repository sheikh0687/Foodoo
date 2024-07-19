//
//  AddedCartCell.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 04/04/24.
//

import UIKit

class AddedCartCell: UITableViewCell {

    
    @IBOutlet weak var lbl_Amount: UILabel!
    @IBOutlet weak var lbl_ProviderName: UILabel!
    @IBOutlet weak var lbl_ItemName: UILabel!
    @IBOutlet weak var item_Img: UIImageView!
    
    @IBOutlet weak var lbl_Quantity: UILabel!
    
    var cloMinus:(() -> Void)?
    var cloAdd:(() -> Void)?
    var cloDelete:(() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btn_Minus(_ sender: UIButton) {
        self.cloMinus?()
    }
    
    @IBAction func btn_Add(_ sender: UIButton) {
        self.cloAdd?()
    }
    
    @IBAction func btn_Delete(_ sender: UIButton) {
        self.cloDelete?()
    }
}
