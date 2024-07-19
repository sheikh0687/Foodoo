//
//  ResSeeAllVC.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 06/04/24.
//

import UIKit
import MapKit
import Cosmos

class ResSeeAllVC: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var viewAll_TableView: UITableView!
    @IBOutlet weak var lbl_Heading: UILabel!
    @IBOutlet weak var btn_ListingOt: UIButton!
    @IBOutlet weak var btn_MapOt: UIButton!
    
    @IBOutlet weak var provider_Img: UIImageView!
    @IBOutlet weak var lbl_ProviderName: UILabel!
    @IBOutlet weak var cosmos_Vw: CosmosView!
    @IBOutlet weak var lbl_ProviderAddress: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var type_View: UIView!
    @IBOutlet weak var search_View: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var subView: UIView!
    
    var location_cordinate:CLLocationCoordinate2D?
    let locationManager = CLLocationManager()
    
    var is_From = ""
    var cat_Id = ""
    var filter_Type = ""
    var start_Time = ""
    var end_Time = ""
    var diet_Type = ""
    
    var arr_ResCategories: [Res_AllRestaurant] = []
    var arr_FilterProduct: [Res_FilterProduct] = []
    
    var arr_RatingReview: [Res_Reviews] = []
    
    var arr_ProductSearchResults: [Res_FilterProduct] = []
    var arr_ResSearchResults: [Res_AllRestaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
        self.viewAll_TableView.register(UINib(nibName: "AllResCell", bundle: nil), forCellReuseIdentifier: "AllResCell")
        self.viewAll_TableView.register(UINib(nibName: "FavCell", bundle: nil), forCellReuseIdentifier: "FavCell")
        self.viewAll_TableView.register(UINib(nibName: "AllReviewCell", bundle: nil), forCellReuseIdentifier: "AllReviewCell")
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.viewAll_TableView.isHidden = false
        self.mapView.isHidden = true
        
        self.arr_ProductSearchResults = self.arr_FilterProduct
        self.arr_ResCategories = self.arr_ResSearchResults
        searchBar.delegate = self
        self.searchBar.showsScopeBar = true
        self.searchBar.returnKeyType = .done
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if is_From == "ShopCategory" {
            self.lbl_Heading.text = "Restaurants".localiz()
            self.type_View.isHidden = false
            self.search_View.isHidden = false
            ResByCategory()
        } else if is_From == "Res" {
            self.lbl_Heading.text = "Restaurants".localiz()
            self.type_View.isHidden = false
            self.search_View.isHidden = false
            ResByCategory()
        } else if is_From == "Magic" {
            self.lbl_Heading.text = "Mystery Mix".localiz()
            self.type_View.isHidden = true
            self.search_View.isHidden = false
            GetFilterProduct()
        } else if is_From == "Review" {
            self.lbl_Heading.text = "Review".localiz()
            self.type_View.isHidden = true
            self.search_View.isHidden = false
        } else {
            GetFilterProduct()
            self.lbl_Heading.text = "Daily Deal".localiz()
            self.type_View.isHidden = true
            self.search_View.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        subView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        subView.frame = self.view.frame
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_Listing(_ sender: UIButton) {
        
        if sender.tag == 0 {
            btn_ListingOt.backgroundColor = R.color.main()
            btn_ListingOt.setTitleColor(.white, for: .normal)
            btn_MapOt.backgroundColor = .clear
            btn_MapOt.setTitleColor(.black, for: .normal)
            self.viewAll_TableView.isHidden = false
            self.mapView.isHidden = true
            self.search_View.isHidden = false
            ResByCategory()
        } else {
            btn_ListingOt.backgroundColor = .clear
            btn_ListingOt.setTitleColor(.black, for: .normal)
            btn_MapOt.backgroundColor = R.color.main()
            btn_MapOt.setTitleColor(.white, for: .normal)
            self.viewAll_TableView.isHidden = true
            self.mapView.isHidden = false
            self.search_View.isHidden = true
            ResByCategory()
        }
    }
    
    @IBAction func btn_Cancel(_ sender: UIButton) {
        subView.removeFromSuperview()
    }
    
    @IBAction func btn_Menu(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ResMenuVC") as! ResMenuVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ResSeeAllVC {
    
    func ResByCategory()
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["token"] = k.emptyString as AnyObject
        paramDict["cat_id"] = cat_Id as AnyObject
        paramDict["start_time"] = start_Time as AnyObject
        paramDict["end_time"] = end_Time as AnyObject
        paramDict["day_name"] = Utility.getCurrentDay() as AnyObject
        paramDict["diet_type_vegan"] = diet_Type as AnyObject
        
        print(paramDict)
        
        Api.shared.restaurant_Lists(self, paramDict) { responseData in
            if responseData.count > 0 {
                self.arr_ResCategories = responseData
                self.arr_ResSearchResults = responseData
                for val in self.arr_ResCategories {
                    let coordinate1 = CLLocationCoordinate2D(latitude: Double(val.lat ?? "") ?? 0.0, longitude: Double(val.lon ?? "") ?? 0.0)
                    
                    let annotation1 = CustomPointAnnotation()
                    annotation1.coordinate = coordinate1
                    annotation1.title = val.provider_name ?? ""
                    annotation1.providerAddress = val.provider_streat_address ?? ""
                    annotation1.imageName = val.provider_logo ?? ""
                    annotation1.providerRating = val.avg_rating ?? ""
                    self.mapView.addAnnotation(annotation1)
                }
                Utility.zoomMapToAnnotations(self.mapView)
            } else {
                self.arr_ResCategories = []
                self.arr_ResSearchResults = []
            }
            self.viewAll_TableView.reloadData()
        }
    }
    
    func GetFilterProduct()
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["token"] = k.emptyString as AnyObject
        paramDict["cat_id"] = k.emptyString as AnyObject
        paramDict["rest_id"] = k.emptyString as AnyObject
        paramDict["size"] = k.emptyString as AnyObject
        paramDict["type"] = filter_Type as AnyObject
        paramDict["lat"] = "" as AnyObject
        paramDict["lon"] = "" as AnyObject
        
        print(paramDict)
        
        Api.shared.filter_Products(self, paramDict) { responseData in
            DispatchQueue.main.async {
                if responseData.count > 0 {
                    self.arr_FilterProduct = responseData
                    self.arr_ProductSearchResults = responseData
                } else {
                    self.arr_FilterProduct = []
                    self.arr_ProductSearchResults = []
                }
                self.viewAll_TableView.reloadData {}
            }
        }
    }
}

extension ResSeeAllVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if is_From == "ShopCategory" || is_From == "Res" {
            self.arr_ResCategories = self.arr_ResSearchResults
            if searchText != "" {
                let filteredArr = self.arr_ResCategories.filter({ $0.provider_name?.range(of: searchText, options: [.diacriticInsensitive, .caseInsensitive]) != nil })
                self.arr_ResCategories = filteredArr
            }
            self.viewAll_TableView.reloadData()
        } else {
            self.arr_FilterProduct = self.arr_ProductSearchResults
            if searchText != "" {
                let filteredArr = self.arr_FilterProduct.filter({ $0.item_name?.range(of: searchText, options: [.diacriticInsensitive, .caseInsensitive]) != nil })
                self.arr_FilterProduct = filteredArr
            }
            self.viewAll_TableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
}

extension ResSeeAllVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // Handle the tap action on the selected annotation view here
        guard let annotation = view.annotation as? CustomPointAnnotation else {
            return
        }
        
        // Show details for the selected annotation
        let providerName = annotation.title ?? ""
        let providerAddress = annotation.providerAddress ?? ""
        let providerLogo = annotation.imageName ?? ""
        let providerRating = annotation.providerRating ?? ""
        showDetailsPopup(providerName: providerName, providerAddress: providerAddress, providerLogo: providerLogo, providerRating: providerRating)
    }
    
    func showDetailsPopup(providerName: String, providerAddress: String, providerLogo: String, providerRating: String) {
        // Example: Instantiate and display a custom popup view controller
        self.view.addSubview(subView)
        self.lbl_ProviderName.text = providerName
        self.lbl_ProviderAddress.text = providerAddress
        self.cosmos_Vw.rating = Double(providerRating) ?? 0.0
        if Router.BASE_IMAGE_URL != providerLogo {
            Utility.setImageWithSDWebImage(providerLogo, self.provider_Img)
        } else {
            self.provider_Img.image = R.image.placeholder()
        }
    }
    
    // MKMapViewDelegate method to customize overlays (polylines)
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let gradientColors = [ hexStringToUIColor(hex: "#000000"), hexStringToUIColor(hex: "#000000")]
        
        /// Initialise a GradientPathRenderer with the colors
        let polylineRenderer = GradientPathRenderer(polyline: overlay as! MKPolyline, colors: gradientColors)
        
        /// set a linewidth
        polylineRenderer.lineWidth = 7
        return polylineRenderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        guard let customAnnotation = annotation as? CustomPointAnnotation else {
            return nil
        }
        
        let identifier = "CustomViewAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: customAnnotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = customAnnotation
        }
        
        if let imageName = customAnnotation.imageName {
            Utility.downloadImageBySDWebImage(imageName) { image, error in
                if let image = image, error == nil {
                    // Set the desired width and height for the circular image
                    let size = CGSize(width: 40, height: 40) // Adjust size as needed
                    let circularImage = image.circularImage(with: size)
                    annotationView?.image = circularImage
                } else {
                    let placeHolderImg = R.image.placeholder()
                    let size = CGSize(width: 40, height: 40)
                    let circularImage = placeHolderImg?.circularImage(with: size)
                    annotationView?.image = circularImage
                }
            }
        } else {
            let placeHolderImg = R.image.placeholder()
            let size = CGSize(width: 40, height: 40)
            let circularImage = placeHolderImg?.circularImage(with: size)
            annotationView?.image = circularImage
        }
        return annotationView
    }
}





