//
//  QuestionCell.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 03/05/24.
//

import UIKit

class QuestionCell: UITableViewCell {

    @IBOutlet weak var lbl_Question: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btn_Question(_ sender: UIButton) {
        
    }
}
