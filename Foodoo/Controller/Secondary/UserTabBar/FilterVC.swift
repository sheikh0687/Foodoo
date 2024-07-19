//
//  FilterVC.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 04/04/24.
//

import UIKit

class FilterVC: UIViewController {

    @IBOutlet weak var filter_CollectionView: UICollectionView!
    @IBOutlet weak var collection_Height: NSLayoutConstraint!
    @IBOutlet weak var btn_AllTimeOt: UIButton!
    @IBOutlet weak var btn_SelectTime: UIButton!
    @IBOutlet weak var switcher_Ot: UISwitch!
    
    var arr_RestCategory: [Res_Category] = []
    var selected_Category: [String] = []
    
    var strStartTime:String! = ""
    var strEndTime:String! = ""
    var strDietType:String! = ""
    
    let language = k.userDefault.value(forKey: k.session.language) as? String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filter_CollectionView.register(UINib(nibName: "FoodTypeCell", bundle: nil), forCellWithReuseIdentifier: "FoodTypeCell")
        self.filter_CollectionView.allowsSelection = true
        WebGetCategory()
        switcher_Ot.isOn = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_Swicth(_ sender: UISwitch) {
        if sender.isOn {
            strDietType = "Yes"
        } else {
            strDietType = "No"
        }
    }
    
    @IBAction func btn_Time(_ sender: UIButton) {
        
        if sender.tag == 0 {
            btn_AllTimeOt.setImage(UIImage(named: "ic_CheckedCircle_Black"), for: .normal)
            btn_SelectTime.setImage(UIImage(named: "ic_Circle_Black"), for: .normal)
        } else {
            btn_AllTimeOt.setImage(UIImage(named: "ic_Circle_Black"), for: .normal)
            btn_SelectTime.setImage(UIImage(named: "ic_CheckedCircle_Black"), for: .normal)
        }
    }
    
    @IBAction func btn_FromTime(_ sender: UIButton) {
        datePickerTapped(strFormat: "yyyy/MM/dd", mode: .time, type: "Time") { date in
            sender.setTitle(date, for: .normal)
            self.strStartTime = date
        }
    }
    
    @IBAction func btn_SelectTime(_ sender: UIButton) {
        datePickerTapped(strFormat: "yyyy/MM/dd", mode: .time, type: "Time") { date in
            sender.setTitle(date, for: .normal)
            self.strEndTime = date
        }
    }
    
    @IBAction func btn_Search(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ResSeeAllVC") as! ResSeeAllVC
        vc.is_From = "Res"
        vc.cat_Id = selected_Category.joined(separator: ",")
        vc.start_Time = strStartTime
        vc.end_Time = strEndTime
        vc.diet_Type = strDietType
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension FilterVC {
    
    func WebGetCategory()
    {
        Api.shared.all_Category(self) { responseData in
            if responseData.count > 0 {
                self.arr_RestCategory = responseData
                let numberOfItemsInRow = 3 // You can adjust this based on your layout
                let numberOfRows = (responseData.count + numberOfItemsInRow - 1) / numberOfItemsInRow
                let cellHeight: CGFloat = 45
                self.collection_Height.constant = CGFloat(numberOfRows) * cellHeight
            } else {
                self.arr_RestCategory = []
            }
            self.filter_CollectionView.reloadData()
        }
    }
}

extension FilterVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arr_RestCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodTypeCell", for: indexPath) as! FoodTypeCell
        let obj = self.arr_RestCategory[indexPath.row]
        cell.lbl_Name.text = obj.category_name ?? ""
        cell.cornerRadius = 10
        cell.borderWidth = 0.5
        cell.borderColor = .separator
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.bounds.width
        return CGSize(width: collectionWidth/3 - 5, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! FoodTypeCell
        let obj = arr_RestCategory[indexPath.item]
        if cell.lbl_Name.backgroundColor == R.color.main() {
            cell.lbl_Name.backgroundColor = .clear
            selected_Category.remove(obj.id ?? "")
            print(selected_Category)
        } else {
            cell.lbl_Name.backgroundColor = R.color.main()
            selected_Category.append(obj.id ?? "")
            print(self.selected_Category)
        }
    }
}
