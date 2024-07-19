//
//  PlacedOrderCell.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 04/04/24.
//

import UIKit

class PlacedOrderCell: UITableViewCell {

    @IBOutlet weak var lbl_ProviderName: UILabel!
    @IBOutlet weak var lbl_Address: UILabel!
    @IBOutlet weak var lbl_OrderId: UILabel!
    @IBOutlet weak var lbl_OrderOnDate: UILabel!
    @IBOutlet weak var lbl_Subtotal: UILabel!
    @IBOutlet weak var lbl_DeliveryFee: UILabel!
    @IBOutlet weak var lbl_Discount: UILabel!
    @IBOutlet weak var lbl_Total: UILabel!
    @IBOutlet weak var lbl_Progress: UILabel!
    
    @IBOutlet weak var item_TableVw: UITableView!
    @IBOutlet weak var item_TableHeight: NSLayoutConstraint!
    @IBOutlet weak var btn_GiveRatingOt: UIButton!
    
    var arr_CartDetails: [Cart_details] = []
    var cloGiveRating:(() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.item_TableVw.register(UINib(nibName: "ItemsCell", bundle: nil), forCellReuseIdentifier: "ItemsCell")
        item_TableVw.dataSource = self
        item_TableVw.delegate = self
    }
    
    func bindItems(arr: [Cart_details]) {
        self.arr_CartDetails = arr
        var heightRow:CGFloat = 0.0
        for val in arr {
            let font = UIFont(name: "Arial", size: 13.0) ?? .systemFont(ofSize: 13)
            let height = heightForView(text: val.extra_item_name ?? "", font: font, width: self.item_TableVw.frame.width)
            let tempRowHeight = 45.0 + height
            heightRow = heightRow + tempRowHeight
        }
        self.item_TableHeight.constant = heightRow
        self.item_TableVw.reloadData()
        print(self.arr_CartDetails)
    }
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btn_GiveRating(_ sender: UIButton) {
        self.cloGiveRating?()
    }
}

extension PlacedOrderCell: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_CartDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemsCell", for: indexPath) as! ItemsCell
        let obj = self.arr_CartDetails[indexPath.row]
        cell.lbl_ItemName.text = "\(obj.quantity ?? "") x \(obj.product_name ?? "")"
        cell.lbl_Amount.text = "$\(obj.total_amount ?? "")"
        
        if let name = obj.extra_item_name, name != "" {
            cell.lbl_ExtraItem.text = obj.extra_item_name ?? ""
        } else {
            cell.lbl_ExtraItem.text = "NA"
        }
        
        return cell
    }
}
