//
//  Api.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 25/04/24.
//

import Foundation
import SkeletonView

class Api: NSObject {
    
    static let shared = Api()
    
    private override init() {}
    
    func paramGetUserId() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        return dict
    }
    
    func login(_ vc: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_Login) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.login.url(), params: param, method: .get, vc: vc, successBlock: {
            (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Login.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.hideProgressBar()
                    k.userDefault.set(false, forKey: k.session.status)
                    k.userDefault.set(k.emptyString, forKey: k.session.userId)
                    k.userDefault.set(k.emptyString, forKey: k.session.userEmail)
                    k.userDefault.set(k.emptyString, forKey: k.session.type)
                    k.userDefault.set(k.emptyString, forKey: k.session.userName)
                    vc.alert(alertmessage: root.message ?? "")
                }
                vc.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func signup(_ vc: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_Login) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.signup.url(), params: param, method: .get, vc: vc, successBlock: {
            (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Login.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.hideProgressBar()
                    k.userDefault.set(false, forKey: k.session.status)
                    k.userDefault.set(k.emptyString, forKey: k.session.userId)
                    k.userDefault.set(k.emptyString, forKey: k.session.userEmail)
                    k.userDefault.set(k.emptyString, forKey: k.session.userName)
                    k.userDefault.set(k.emptyString, forKey: k.session.type)
                    vc.alert(alertmessage: root.message ?? "Something Went Wrong")
                }
                vc.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func social_Login(_ vc: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_Login) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.social_login.url(), params: param, method: .get, vc: vc, successBlock: {
            (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Login.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.hideProgressBar()
                    k.userDefault.set(false, forKey: k.session.status)
                    k.userDefault.set(k.emptyString, forKey: k.session.userId)
                    k.userDefault.set(k.emptyString, forKey: k.session.userEmail)
                    k.userDefault.set(k.emptyString, forKey: k.session.type)
                    k.userDefault.set(k.emptyString, forKey: k.session.userName)
                    vc.alert(alertmessage: root.message ?? "")
                }
                vc.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }

    func verify_MobileNumber(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : Res_VerifyNumber) -> Void) {
        vc.blockUi()
        Service.post(url: Router.verify_number.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_VerifyNum.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? "Something Went Wrong!")
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func get_Profile(_ vc: UIViewController, _ success: @escaping(_ responseData : Res_Login) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.get_profile.url(), params: paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Login.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                }
                vc.hideProgressBar()
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func update_UserProfile(_ vc: UIViewController, _ params: [String: String], images: [String : UIImage?]?, videos: [String : Data?]?, _ success: @escaping(_ responseData : Res_Login) -> Void) {
        vc.showProgressBar()
        Service.postSingleMedia(url: Router.update_profile.url(), params: params, imageParam: images, videoParam: videos, parentViewController: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Login.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? "Something went wrong")
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func forgot_Password(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : Api_Basic) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.forgot_password.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Basic.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func update_Password(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : Api_Basic) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.change_password.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Basic.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func all_Category(_ vc: UIViewController, _ success: @escaping(_ responseData : [Res_Category]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.get_Category.url(), params: paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Category.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                }
                vc.hideProgressBar()
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func add_RestuarntRating(_ vc: UIViewController,_ params: [String : AnyObject],_ success: @escaping(_ responseData : Res_AddRating) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.add_rating_review_by_order.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Rating.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func fav_Products(_ vc: UIViewController,_ param: [String : AnyObject], _ success: @escaping(_ responseData : Api_FavProducts) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.get_my_fav_product.url(), params: param, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_FavProducts.self, from: response)
                if root.result != nil {
                    success(root)
                }
                vc.hideProgressBar()
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func fav_Providers(_ vc: UIViewController,_ param: [String : AnyObject], _ success: @escaping(_ responseData : Api_FavProvider) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.get_my_fav_provider.url(), params: param, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_FavProvider.self, from: response)
                if root.result != nil {
                    success(root)
                }
                vc.hideProgressBar()
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func restaurant_Lists(_ vc: UIViewController,_ param: [String : AnyObject], _ success: @escaping(_ responseData : [Res_AllRestaurant]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.get_all_rest_list.url(), params: param, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Restaurant.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                }
                vc.hideProgressBar()
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func cart_Details(_ vc: UIViewController,_ success: @escaping(_ responseData : Api_Cart) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.get_cart.url(), params: paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Cart.self, from: response)
                if root.result != nil {
                    success(root)
                }
                vc.hideProgressBar()
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func update_AllCart(_ vc: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData : Api_UpdateCart) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.update_cart.url(), params: param, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_UpdateCart.self, from: response)
                if root.result != nil {
                    success(root)
                }
                vc.hideProgressBar()
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func delete_Cart(_ vc: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData : Api_Basic) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.delete_cart_item.url(), params: param, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Basic.self, from: response)
                if root.result != nil {
                    success(root)
                }
                vc.hideProgressBar()
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func filter_Products(_ vc: UIViewController,_ param: [String : AnyObject], _ success: @escaping(_ responseData : [Res_FilterProduct]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.get_product_list_by_filter.url(), params: param, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_FilterProduct.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                }
                vc.hideProgressBar()
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func products_Detail(_ vc: UIViewController,_ param: [String : AnyObject], _ success: @escaping(_ responseData : Res_ProductDt) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.get_product_details.url(), params: param, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_ProductDetails.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                }
                vc.hideProgressBar()
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func provider_Reviews(_ vc: UIViewController,_ param: [String : AnyObject], _ success: @escaping(_ responseData : Api_Reviews) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.get_provider_review_rating.url(), params: param, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Reviews.self, from: response)
                if root.result != nil {
                    success(root)
                }
                vc.hideProgressBar()
            } catch {
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func likeAndUnlike_Product(_ vc: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Api_Basic) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.like_unlike_product.url(), params: param, method: .get, vc: vc, successBlock: {(response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Basic.self, from: response)
                if root.result != nil {
                    success(root)
                }
                vc.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func fav_AndUnFavProvider(_ vc: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Api_Basic) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.fav_unfav_provider.url(), params: param, method: .get, vc: vc, successBlock: {(response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Basic.self, from: response)
                if root.result != nil {
                    success(root)
                }
                vc.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func wallet_TransactionHistory(_ vc: UIViewController,_ success: @escaping(_ responseData: Api_TransactionHistory) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.get_transaction.url(), params: paramGetUserId(), method: .get, vc: vc, successBlock: {(response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_TransactionHistory.self, from: response)
                if root.result != nil {
                    success(root)
                }
                vc.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func addTo_Cart(_ vc: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Api_AddToCart) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.add_to_cart_product.url(), params: param, method: .get, vc: vc, successBlock: {(response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_AddToCart.self, from: response)
                if root.result != nil {
                    success(root)
                }
                vc.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func faqs_Details(_ vc: UIViewController,_ success: @escaping(_ responseData: Api_FAQs) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.get_faq.url(), params: paramGetUserId(), method: .get, vc: vc, successBlock: {(response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_FAQs.self, from: response)
                if root.result != nil {
                    success(root)
                }
                vc.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func order_Status(_ vc: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Api_OrderStatus) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.get_user_order_by_status.url(), params: param, method: .get, vc: vc, successBlock: {(response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_OrderStatus.self, from: response)
                if root.result != nil {
                    success(root)
                }
                vc.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func place_Order(_ vc: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_PlaceOrder) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.place_order.url(), params: param, method: .get, vc: vc, successBlock: {(response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_PlacedOrder.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? "")
                }
                vc.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func add_Payment(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : AnyObject) -> Void) {
        vc.blockUi()
        vc.showProgressBar()
        Service.callPostService(apiUrl: Router.add_Payment_Wallet.url(), parameters: params, Method: .get, parentViewController: vc, successBlock: { (response, message) in
            success(response)
            vc.unBlockUi()
            vc.hideProgressBar()
        }) { (error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
            vc.hideProgressBar()
        }
    }
    
    func send_Feedback(_ vc: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_Contact) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.send_feedback.url(), params: param, method: .get, vc: vc, successBlock: {(response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_ContactInfo.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? "")
                }
                vc.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
}
