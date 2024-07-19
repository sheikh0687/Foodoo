//
//  UserProfileVC.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 04/04/24.
//

import UIKit
import CountryPickerView

class UserProfileVC: UIViewController {
    
    @IBOutlet weak var txt_FirstName: UITextField!
    @IBOutlet weak var txt_LastName: UITextField!
    @IBOutlet weak var txt_Mobile: UITextField!
    @IBOutlet weak var txt_Email: UITextField!
    @IBOutlet weak var txt_CountryPicker: UITextField!
    @IBOutlet weak var btn_ImgProfile: UIButton!
    
    weak var cpvTextField: CountryPickerView!
    var phoneKey:String?
    var phoneNumber: String = ""
    
    var image = UIImage()
    
    let language = k.userDefault.value(forKey: k.session.language) as? String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCountryView()
        self.tabBarController?.tabBar.isHidden = false
        GetProfile()
    }
    
    func configureCountryView() {
        let cp = CountryPickerView(frame: CGRect(x: 0, y: 0, width: 80, height: 14))
        cp.flagImageView.isHidden = true
        if language == "arabic" {
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
    
    @IBAction func btn_TapImg(_ sender: UIButton) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.image = image
            sender.contentMode = .scaleToFill
            sender.setImage(image, for: .normal)
        }
    }
    
    @IBAction func btn_Update(_ sender: UIButton) {
        if self.txt_Email.hasText && self.txt_FirstName.hasText && self.txt_LastName.hasText && txt_Mobile.hasText {
            WebUpdateProfile()
        } else {
            self.alert(alertmessage: "Please enter the required details".localiz())
        }
    }
}

extension UserProfileVC {
    
    func GetProfile()
    {
        Api.shared.get_Profile(self) { responseData in
            let obj = responseData
            self.txt_FirstName.text = obj.first_name ?? ""
            self.txt_LastName.text = obj.last_name ?? ""
            self.txt_Mobile.text = obj.mobile ?? ""
            self.txt_Email.text = obj.email ?? ""
            
            if Router.BASE_IMAGE_URL != obj.image {
                Utility.downloadImageBySDWebImage(obj.image ?? "") { image, error in
                    if error == nil {
                        self.btn_ImgProfile.setImage(image, for: .normal)
                    } else {
                        self.btn_ImgProfile.setImage(R.image.placeholder(), for: .normal)
                    }
                }
            } else {
                self.btn_ImgProfile.setImage(R.image.placeholder(), for: .normal)
            }
        }
    }
    
    func WebUpdateProfile()
    {
        var param_Dict: [String : String]  = [:]
        param_Dict["user_id"]              = k.userDefault.value(forKey: k.session.userId) as? String
        param_Dict["first_name"]           = self.txt_FirstName.text
        param_Dict["last_name"]            = self.txt_LastName.text
        param_Dict["mobile"]               = self.txt_Mobile.text
        param_Dict["email"]                = self.txt_Email.text
        param_Dict["mobile_with_code"]     = self.phoneKey
        param_Dict["lat"]                  = kAppDelegate.CURRENT_LAT
        param_Dict["lon"]                  = kAppDelegate.CURRENT_LON
        
        print(param_Dict)
        
        var imageDict: [String : UIImage] = [:]
        imageDict["image"]                = self.image
        
        Api.shared.update_UserProfile(self, param_Dict, images: imageDict, videos: [:]) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.profileUpdatedSuccessfully(), delegate: nil, parentViewController: self) { bool in
                self.dismiss(animated: true)
            }
        }
    }
}

extension UserProfileVC: CountryPickerViewDelegate {
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.phoneKey = country.phoneCode
    }
}

extension UserProfileVC: CountryPickerViewDataSource {
    
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
