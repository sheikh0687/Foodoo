//
//  RatingProductVC.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 17/05/24.
//

import UIKit
import Cosmos

class RatingProductVC: UIViewController {
    
    @IBOutlet weak var cosmosVw: CosmosView!
    @IBOutlet weak var txt_Feedback: UITextView!
    
    var provider_Id:String! = ""
    var req_Id:String! = ""
    
    var clo_Refresh:(() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txt_Feedback.addHint("Enter".localiz())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_Done(_ sender: UIButton) {
        if cosmosVw.rating.isZero {
            self.alert(alertmessage: "Please select ratings".localiz())
        } else if self.txt_Feedback.text == "" {
            self.alert(alertmessage: "Please enter the feedback".localiz())
        } else {
            RateRestuarantt()
        }
    }
}

extension RatingProductVC {
    
    func RateRestuarantt()
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
        paramDict["provider_id"]            = self.provider_Id as AnyObject
        paramDict["request_id"]             = self.req_Id as AnyObject
        paramDict["driver_id"]              = k.emptyString as AnyObject
        paramDict["type"]                   = "USER" as AnyObject
        paramDict["rating"]                 = Double(self.cosmosVw.rating) as AnyObject
        paramDict["review"]                 = self.txt_Feedback.text as AnyObject
    
        print(paramDict)
        
        Api.shared.add_RestuarntRating(self, paramDict) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: "Rating submitted successfully".localiz(), delegate: nil, parentViewController: self) { bool in
                self.clo_Refresh?()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
