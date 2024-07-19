//
//  SignupVC.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 28/03/24.
//

import UIKit
import CountryPickerView
import LanguageManager_iOS

class SignupVC: UIViewController {
    
    @IBOutlet weak var txt_FirstName: UITextField!
    @IBOutlet weak var txt_LastName: UITextField!
    @IBOutlet weak var txt_Email: UITextField!
    @IBOutlet weak var txt_Mobile: UITextField!
    @IBOutlet weak var txt_CountryPicker: UITextField!
    @IBOutlet weak var txt_Password: UITextField!
    @IBOutlet weak var txt_ConfirmPassword: UITextField!
    @IBOutlet weak var txt_RefferalCode: UITextField!
    @IBOutlet weak var lbl_Web: UILabel!
    @IBOutlet weak var btn_CheckBox: UIButton!
    
    weak var cpvTextField: CountryPickerView!
    
    var phoneKey:String! = ""
    var phoneNumber: String = ""
    
    var strCheck:String = ""
    
    let language = k.userDefault.value(forKey: k.session.language) as? String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCountryView()
        btn_CheckBox.setImage(R.image.rectangleUncheck(), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func configureCountryView() {
        let cp = CountryPickerView(frame: CGRect(x: 0, y: 0, width: 80, height: 14))
        cp.flagImageView.isHidden = true
        if LanguageManager.shared.currentLanguage == .ar {
            txt_CountryPicker.leftView = cp
            txt_CountryPicker.leftViewMode = .always
        } else {
            txt_CountryPicker.rightView = cp
            txt_CountryPicker.rightViewMode = .always
        }
        self.cpvTextField = cp
        let countryCode = "US"
        self.cpvTextField.setCountryByCode(countryCode)
        cp.delegate = self
        [cp].forEach {
            $0?.dataSource = self
        }
        self.phoneKey = cp.selectedCountry.phoneCode
        cp.countryDetailsLabel.font = UIFont.systemFont(ofSize: 12)
        cp.font = UIFont.systemFont(ofSize: 12)
    }
    
    @IBAction func btn_Check(_ sender: UIButton) {
        if btn_CheckBox.image(for: .normal) != R.image.rectangleChecked() {
            btn_CheckBox.setImage(R.image.rectangleChecked(), for: .normal)
            strCheck = "Checked"
        } else {
            btn_CheckBox.setImage(R.image.rectangleUncheck(), for: .normal)
            strCheck = ""
        }
    }
    
    @IBAction func btn_Register(_ sender: UIButton) {
        if isValidInput() {
            CheckValidNumber()
        }
    }
    
    func isValidInput() -> Bool
    {
        var isValid: Bool = true
        var error_Message: String = ""
        
        if (txt_FirstName.text?.isEmpty)! {
            isValid = false
            error_Message = "Please enter the first name".localiz()
        } else if (txt_LastName.text?.isEmpty)! {
            isValid = false
            error_Message = "Please enter the last name".localiz()
        } else if (txt_Email.text?.isEmpty)! {
            isValid = false
            error_Message = "Please enter the email".localiz()
        } else if (txt_Mobile.text?.isEmpty)! {
            isValid = false
            error_Message = "Please enter the mobile number".localiz()
        } else if (txt_Password.text?.isEmpty)! {
            isValid = false
            error_Message = "Please enter the password".localiz()
        } else if (txt_ConfirmPassword.text?.isEmpty)! {
            isValid = false
            error_Message = "Please enter the confirm password".localiz()
        } else if txt_Password.text != txt_ConfirmPassword.text {
            isValid = false
            error_Message = "Please enter the same password".localiz()
        } else if strCheck == "" {
            isValid = false
            error_Message = "Please check the Terms and Condition".localiz()
        }
        
        if (isValid == false)
        {
            Utility.showAlertMessage(withTitle: k.appName, message: error_Message, delegate: nil, parentViewController: self)
        }
        
        return isValid
    }
    
    func CheckValidNumber(shouldNavigate: Bool = true)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["mobile_with_code"]       = "\(self.phoneKey ?? "")\(self.txt_Mobile.text!)" as AnyObject
        paramDict["mobile"]                 = self.txt_Mobile.text as AnyObject
        paramDict["email"]                  = self.txt_Email.text as AnyObject
        paramDict["type"]                   = "USER" as AnyObject
        
        print(paramDict)
        
        Api.shared.verify_MobileNumber(self, paramDict) { responseData in
            self.collect_Data()
            print(self.collect_Data())
            if shouldNavigate {
                let vc = R.storyboard.main().instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
                vc.verificationCode = responseData.code ?? ""
                vc.cloResend = { () in
                    self.CheckValidNumber(shouldNavigate: false)
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func collect_Data()
    {
        dictSignup["first_name"] = txt_FirstName.text as AnyObject
        dictSignup["last_name"] = txt_LastName.text as AnyObject
        dictSignup["mobile"] = txt_Mobile.text as AnyObject
        dictSignup["mobile_with_code"] = phoneKey + txt_Mobile.text! as AnyObject
        dictSignup["email"] = txt_Email.text as AnyObject
        dictSignup["password"] = txt_Password.text as AnyObject
        dictSignup["register_id"] = k.emptyString as AnyObject
        dictSignup["ios_register_id"] = k.iosRegisterId as AnyObject
        dictSignup["type"] = "USER" as AnyObject
        dictSignup["address"] = k.emptyString as AnyObject
        dictSignup["lat"] = kAppDelegate.CURRENT_LAT as AnyObject
        dictSignup["lon"] = kAppDelegate.CURRENT_LON as AnyObject
    }
    
    @IBAction func btn_LoginNow(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SignupVC: CountryPickerViewDelegate {
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.phoneKey = country.phoneCode
    }
}

extension SignupVC: CountryPickerViewDataSource {
    
    func preferredCountries(in countryPickerView: CountryPickerView) -> [Country] {
        var countries = [Country]()
        ["GB"].forEach { code in
            if let country = countryPickerView.getCountryByCode(code) {
                countries.append(country)
            }
        }
        return countries
    }
    
    func sectionTitleForPreferredCountries(in countryPickerView: CountryPickerView) -> String? {
        return "Preferred title"
    }
    
    func showOnlyPreferredSection(in countryPickerView: CountryPickerView) -> Bool {
        return false
    }
    
    func navigationTitle(in countryPickerView: CountryPickerView) -> String? {
        return "Select a Country"
    }
}
