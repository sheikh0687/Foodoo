//
//  LanguageVC.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 21/05/24.
//

import UIKit
import LanguageManager_iOS

class LanguageVC: UIViewController {

    @IBOutlet weak var btn_EnglishOt: UIButton!
    @IBOutlet weak var btn_ArabicOt: UIButton!
    @IBOutlet weak var btn_TurkishOt: UIButton!
    
    var selected_Language = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        if LanguageManager.shared.currentLanguage == .en {
            btn_EnglishOt.setImage(R.image.ic_CheckedCircle_Black(), for: .normal)
            btn_EnglishOt.setTitle("English", for: .normal)
            btn_ArabicOt.setTitle("Arabic", for: .normal)
            btn_TurkishOt.setTitle("Turkish", for: .normal)
        } else if LanguageManager.shared.currentLanguage == .ar {
            btn_ArabicOt.setImage(R.image.ic_CheckedCircle_Black(), for: .normal)
            btn_EnglishOt.setTitle("الإنجليزية", for: .normal)
            btn_ArabicOt.setTitle("الإنجليزية", for: .normal)
            btn_TurkishOt.setTitle("التركية", for: .normal)
        } else {
            btn_TurkishOt.setImage(R.image.ic_CheckedCircle_Black(), for: .normal)
            btn_EnglishOt.setTitle("İngilizce", for: .normal)
            btn_ArabicOt.setTitle("Arapça", for: .normal)
            btn_TurkishOt.setTitle("Türkçe", for: .normal)
        }
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        if LanguageManager.shared.isRightToLeft {
            toggleRight()
        } else {
           toggleLeft()
        }
    }
    
    @IBAction func btn_Languages(_ sender: UIButton) {
        
        if sender.tag == 0 {
            btn_EnglishOt.setImage(R.image.ic_CheckedCircle_Black(), for: .normal)
            btn_ArabicOt.setImage(R.image.ic_Circle_Black(), for: .normal)
            btn_TurkishOt.setImage(R.image.ic_Circle_Black(), for: .normal)
            selected_Language = "en"
        } else if sender.tag == 1 {
            btn_EnglishOt.setImage(R.image.ic_Circle_Black(), for: .normal)
            btn_ArabicOt.setImage(R.image.ic_CheckedCircle_Black(), for: .normal)
            btn_TurkishOt.setImage(R.image.ic_Circle_Black(), for: .normal)
            selected_Language = "ar"
        } else {
            btn_EnglishOt.setImage(R.image.ic_Circle_Black(), for: .normal)
            btn_ArabicOt.setImage(R.image.ic_Circle_Black(), for: .normal)
            btn_TurkishOt.setImage(R.image.ic_CheckedCircle_Black(), for: .normal)
            selected_Language = "tr"
        }
    }
    
    
    @IBAction func btn_Submit(_ sender: UIButton) {
        
        if selected_Language == "en" {
            k.userDefault.set(emLang.english.rawValue, forKey: k.session.language)
            LanguageManager.shared.setLanguage(language: .en)
            Switcher.updateRootVC()
        } else if selected_Language == "ar" {
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
