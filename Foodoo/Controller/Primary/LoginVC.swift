//
//  LoginVC.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 28/03/24.
//

import UIKit
import DropDown
import LanguageManager_iOS
import GoogleSignIn

class LoginVC: UIViewController {
    
    @IBOutlet weak var txt_Email: UITextField!
    @IBOutlet weak var txt_Password: UITextField!
    @IBOutlet weak var lbl_Language: UILabel!
    @IBOutlet weak var btn_GoogleSignOt: UIButton!
    
    var dropDown = DropDown()
    
    let language = k.userDefault.value(forKey: k.session.language) as? String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if LanguageManager.shared.currentLanguage == .en {
            btn_GoogleSignOt.setTitle("Login with Google Account", for: .normal)
        } else if LanguageManager.shared.currentLanguage == .ar {
            btn_GoogleSignOt.setTitle("تسجيل الدخول بحساب جوجل", for: .normal)
        } else {
            btn_GoogleSignOt.setTitle("Google Hesabı ile Giriş", for: .normal)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btn_Language(_ sender: UIButton) {
        dropDown.anchorView = sender
        dropDown.show()
        switch language {
        case "english":
            dropDown.dataSource = ["English","Arabic","Turkish"]
            dropDown.bottomOffset = CGPoint(x: -60, y: 40)
        case "arabic":
            dropDown.dataSource = ["إنجليزي","عربي","التركية"]
            dropDown.bottomOffset = CGPoint(x: 280, y: 40)
        default:
            dropDown.dataSource = ["İngilizce","Arapça","Türkçe"]
            dropDown.bottomOffset = CGPoint(x: -60, y: 40)
        }
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.lbl_Language.text = item
            if index == 0 {
                k.userDefault.set(emLang.english.rawValue, forKey: k.session.language)
                LanguageManager.shared.setLanguage(language: .en)
                Switcher.updateRootVC()
            } else if index == 1 {
                k.userDefault.set(emLang.arabic.rawValue, forKey: k.session.language)
                LanguageManager.shared.setLanguage(language: .ar)
                Switcher.updateRootVC()
            } else {
                k.userDefault.set(emLang.turkish.rawValue, forKey: k.session.language)
                LanguageManager.shared.setLanguage(language: .tr)
                Switcher.updateRootVC()
            }
        }
    }
    
    @IBAction func btn_Login(_ sender: UIButton) {
        if isValidInput() {
            CheckEmailStatus()
        }
    }
    
    // MARK: - Validation
    func isValidInput() -> Bool {
        var isValid: Bool = true;
        var errorMessage: String = ""
        
        if (txt_Email.text?.isEmpty)! {
            isValid = false
            errorMessage = "Please enter the valid email".localiz()
        } else if (txt_Password.text?.isEmpty)! {
            isValid = false
            errorMessage = "Please enter the password".localiz()
        }
        
        if (isValid == false) {
            Utility.showAlertMessage(withTitle: k.appName, message: errorMessage, delegate: nil, parentViewController: self)
        }
        
        return isValid
    }
    
    func CheckEmailStatus() {
        
        var paramDict: [String : AnyObject] = [:]
        paramDict["email"] = txt_Email.text as AnyObject
        paramDict["password"] = txt_Password.text as AnyObject
        paramDict["ios_register_id"] = k.iosRegisterId as AnyObject
        paramDict["register_id"] = k.emptyString as AnyObject
        paramDict["lat"] = kAppDelegate.CURRENT_LAT as AnyObject
        paramDict["lon"] = kAppDelegate.CURRENT_LON as AnyObject
        
        print(paramDict)
        
        Api.shared.login(self, paramDict) { responseData in
            k.userDefault.set(true, forKey: k.session.status)
            k.userDefault.set(responseData.id ?? "", forKey: k.session.userId)
            k.userDefault.set(responseData.email ?? "", forKey: k.session.userEmail)
            Switcher.updateRootVC()
        }
    }
    
    @IBAction func btn_ForgetPassword(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_SingUpNoew(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_GooglLogin(_ sender: UIButton) {
        self.googleSignIn()
    }
}

extension LoginVC {
    
    func paramSocialLogin(fName: String,lName: String,email: String,mobile: String, socialId: String) -> [String:AnyObject] {
        
        var dict:[String: AnyObject] = [:]
        dict["first_name"] = fName as AnyObject
        dict["last_name"] = lName as AnyObject
        dict["email"] = email as AnyObject
        dict["mobile"] = mobile as AnyObject
        dict["social_id"] = socialId as AnyObject
        dict["register_id"] = k.emptyString as AnyObject
        dict["ios_register_id"] = k.iosRegisterId as AnyObject
        dict["lat"]   = kAppDelegate.CURRENT_LAT as AnyObject
        dict["lon"]  = kAppDelegate.CURRENT_LON as AnyObject
        dict["type"]  = "USER" as AnyObject
        print(dict)
        return dict
    }
    
    func loginWithGoogle(fName: String,lName: String,email: String,mobile: String, socialId: String) {
        
        Api.shared.social_Login(self, paramSocialLogin(fName: fName, lName: "", email: email, mobile: k.emptyString, socialId: socialId)) { responseData in
            k.userDefault.set(true, forKey: k.session.status)
            k.userDefault.set(responseData.id ?? "", forKey: k.session.userId)
            k.userDefault.set(responseData.email ?? "", forKey: k.session.userEmail)
            Switcher.updateRootVC()
        }
    }
}

extension LoginVC {
    
    private func googleSignIn() {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] result, error in
            if let error {
                // you can add error handling
                print("Error", error)
                return
            }
            
            guard let fullName = result?.user.profile?.name else { return }
            guard let userId = result?.user.userID else { return }
            guard let emailAddress = result?.user.profile?.email else { return }
            guard let tokenId = result?.user.idToken else { return }
            
            self?.loginWithGoogle(fName: fullName, lName: k.emptyString, email: emailAddress, mobile: k.emptyString, socialId: userId)
        }
    }
}
