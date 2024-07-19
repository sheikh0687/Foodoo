//
//  PaymentVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 28/10/23.
//

import UIKit
import InputMask
import SwiftyJSON
import StripePayments
import LanguageManager_iOS

class PaymentVC: UIViewController {

    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var txtCardHolderName: UITextField!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var txtExpiryDate: UITextField!
    @IBOutlet weak var txtSecurityCode: UITextField!
    @IBOutlet var listnerCardNum: MaskedTextFieldDelegate!
    @IBOutlet var listerExpiryDate: MaskedTextFieldDelegate!
    
    var amount = 0.0
    var requestId = ""
    var providerId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblAmount.text = "\(k.currency) \(self.amount)"
        self.configureListener()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func configureListener()
    {
        listnerCardNum.affinityCalculationStrategy = .prefix
        listnerCardNum.affineFormats = ["[0000] [0000] [0000] [0000]"]
        
        listerExpiryDate.affinityCalculationStrategy = .prefix
        listerExpiryDate.affineFormats = ["[00]/[00]"]
    }
    
    func cardValidation()
    {
        let cardParams = STPCardParams()
        
        // Split the expiration date to extract Month & Year
        if self.txtCardHolderName.text?.isEmpty == false && self.txtSecurityCode.text?.isEmpty == false && self.txtExpiryDate.text?.isEmpty == false && self.txtExpiryDate.text?.isEmpty == false {
            let expirationDate = self.txtExpiryDate.text?.components(separatedBy: "/")
            let expMonth = UInt((expirationDate?[0])!)
            let expYear = UInt((expirationDate?[1])!)
            
            // Send the card info to Strip to get the token
            cardParams.number = self.txtCardNumber.text
            cardParams.cvc = self.txtSecurityCode.text
            cardParams.expMonth = expMonth!
            cardParams.expYear = expYear!
        }
        
        let cardState = STPCardValidator.validationState(forCard: cardParams)
        switch cardState {
        case .valid:
            self.generateToken(cardParams)
        case .invalid:
            self.alert(alertmessage: "Card is invalid".localiz())
        case .incomplete:
            self.alert(alertmessage: "Card is incomplete".localiz())
        default:
            print("default")
        }
    }
    
    @IBAction func btnSubmit(_ sender: UIButton)
    {
        self.cardValidation()
    }
    
    func generateToken(_ cardParams: STPCardParams)
    {
        STPAPIClient.shared.createToken(withCard: cardParams) { (token: STPToken?, error: Error?) in
            guard let token = token, error == nil else {
                Utility.showAlertWithAction(withTitle: k.appName, message: "Something went wrong".localiz(), delegate: nil, parentViewController: self, completionHandler: { (boool) in
                })
                return
            }
            print(token.tokenId)
            self.PaymentIntegration(token.tokenId)
        }
    }
    
    func PaymentIntegration(_ tokenId: String)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["payment_method"] = "Card" as AnyObject
        paramDict["total_amount"] = amount as AnyObject
        paramDict["provider_id"] = providerId as AnyObject
        paramDict["request_id"] = requestId as AnyObject
        paramDict["transaction_id"] = "" as AnyObject
        paramDict["currency"] = "CAD" as AnyObject
        paramDict["token"] = tokenId as AnyObject
        if is_Navigate == "Order" {
            paramDict["transaction_type"] = "Order" as AnyObject
        } else {
            paramDict["transaction_type"] = "Top Up" as AnyObject
        }
        print(paramDict)
        
        Api.shared.add_Payment(self, paramDict) { responseData in
            self.parseDataSaveCard(apiResponse: responseData)
        }
    }
    
    func parseDataSaveCard(apiResponse : AnyObject) {
        DispatchQueue.main.async {
            let swiftyJsonVar = JSON(apiResponse)
            print(swiftyJsonVar)
            if(swiftyJsonVar["status"] == "1") {
                print(swiftyJsonVar["result"]["id"].stringValue)
                let vc = R.storyboard.main().instantiateViewController(withIdentifier: "PresentPaymentPopVC") as! PresentPaymentPopVC
                vc.cloBack = {() in
                    self.navigationController?.popViewController(animated: true)
                }
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
            } else {
                Utility.showAlertWithAction(withTitle: k.appName, message: "Something went wrong".localiz(), delegate: nil, parentViewController: self, completionHandler: { (boool) in
                })
            }
            self.unBlockUi()
        }
    }
}

