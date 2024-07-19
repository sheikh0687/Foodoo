//
//  FAQ'sVC.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 10/04/24.
//

import UIKit
import LanguageManager_iOS

class FAQ_sVC: UIViewController {
    
    @IBOutlet weak var faq_TableView: UITableView!
    
    var faq_Section = [ExpandedTableView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        faq_TableView.register(UINib(nibName: "QuestionCell", bundle: nil), forCellReuseIdentifier: "QuestionCell")
        faq_TableView.register(UINib(nibName: "AnswerCell", bundle: nil), forCellReuseIdentifier: "AnswerCell")
        GetFaqs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        if LanguageManager.shared.isRightToLeft {
            toggleRight()
        } else {
           toggleLeft()
        }
    }
}

extension FAQ_sVC {
    
    func GetFaqs() {
        Api.shared.faqs_Details(self) { responseData in
            let result = responseData.result
            if result?.count ?? 0 > 0 {
                self.faq_Section = result!.map { ExpandedTableView(option: [$0], isOpened: false) }
            } else {
                self.faq_Section = []
                self.faq_TableView.reloadData()
                Utility.noDataFound(R.string.localizable.noDataAvailable(), tableViewOt: self.faq_TableView, parentViewController: self)
            }
            self.faq_TableView.reloadData()
        }
    }
}

extension FAQ_sVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return faq_Section.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faq_Section[section].isOpened ? faq_Section[section].option.count + 1 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath) as! QuestionCell
            let obj = self.faq_Section[indexPath.section]
            cell.lbl_Question.text = obj.option.first?.question
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath) as! AnswerCell
            let obj = self.faq_Section[indexPath.section].option.first
            cell.lbl_Answer.text = obj?.answer ?? ""
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            faq_Section[indexPath.section].isOpened.toggle()
            tableView.reloadSections([indexPath.section], with: .none)
        } else {
            print("Tapped Sub Cell")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = faq_Section[indexPath.section]
        return section.isOpened ? UITableView.automaticDimension : 50
    }
}
