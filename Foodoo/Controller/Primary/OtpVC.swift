//
//  OtpVC.swift
//  FoodooRestaurant
//
//  Created by Techimmense Software Solutions on 17/04/24.
//

import UIKit

class OtpVC: UIViewController {

    @IBOutlet weak var txt_1: UITextField!
    @IBOutlet weak var txt_2: UITextField!
    @IBOutlet weak var txt_3: UITextField!
    @IBOutlet weak var txt_4: UITextField!
    
    var verificationCode = ""
    var cloResend:(() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func txt_1(_ sender: UITextField) {
        if sender.text! != "" {
            self.txt_2.becomeFirstResponder()
        }
    }
    
    @IBAction func txt_2(_ sender: UITextField) {
        if sender.text! != "" {
            self.txt_3.becomeFirstResponder()
        }
    }
    
    @IBAction func txt_3(_ sender: UITextField) {
        if sender.text! != "" {
            self.txt_4.becomeFirstResponder()
        }
    }
    
    @IBAction func txt_4(_ sender: UITextField) {
        if sender.text! != "" {
        }
    }
    
    func checkVerificationCode()
    {
        if txt_1.hasText && txt_2.hasText && txt_3.hasText && txt_4.hasText {
            let v1 = self.txt_1.text!
            let v2 = self.txt_2.text!
            let v3 = self.txt_3.text!
            let v4 = self.txt_4.text!
            
            let verificationCode = "\(v1)\(v2)\(v3)\(v4)"
            self.otpVerification(verificationCode)
        } else {
            self.alert(alertmessage: "Please enter otp".localiz())
        }
    }
    
    func otpVerification(_ verificationCode: String)
    {
        let ottp = verificationCode
        if self.verificationCode == ottp {
            CheckSignupStatus()
        } else {
            self.txt_1.text = ""
            self.txt_2.text = ""
            self.txt_3.text = ""
            self.txt_4.text = ""
            self.txt_1.becomeFirstResponder()
            self.alert(alertmessage: "Invalid Otp".localiz())
        }
    }
    
    func CheckSignupStatus()
    {
        Api.shared.signup(self, dictSignup) { responseData in
            k.userDefault.set(true, forKey: k.session.status)
            k.userDefault.set(responseData.id ?? "", forKey: k.session.userId)
            k.userDefault.set(responseData.email ?? "", forKey: k.session.userEmail)
            Switcher.updateRootVC()
        }
    }
    
    @IBAction func btn_Submit(_ sender: UIButton) {
        checkVerificationCode()
    }
    
    @IBAction func btn_Resend(_ sender: UIButton) {
        self.cloResend?()
    }
}
