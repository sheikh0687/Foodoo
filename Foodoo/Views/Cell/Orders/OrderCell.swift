//
//  OrderCell.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 28/03/24.
//

import UIKit

class OrderCell: UITableViewCell {

    @IBOutlet weak var btn_GiveRating: UIButton!
    
    var cloOrderDetail:(() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func btn_GiveRating(_ sender: UIButton) {
        
    }
    
    @IBAction func btn_Chat(_ sender: UIButton) {
        
    }
    
    @IBAction func btn_MarkComplete(_ sender: UIButton) {
        
    }
    
    @IBAction func btn_Details(_ sender: UIButton) {
        self.cloOrderDetail?()
    }
}
