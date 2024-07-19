//
//  Router.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 25/04/24.
//

import Foundation

enum Router: String {
    
    static let BASE_SERVICE_URl = "https://techimmense.in/foodoo/webservice/"
    static let BASE_IMAGE_URL = "https://techimmense.in/foodoo/uploads/images/"
    
    case login
    case signup
    case verify_number
    case forgot_password
    case change_password
    case social_login
    
    case get_profile
    case get_Category
    case get_my_fav_product
    case get_my_fav_provider
    case get_all_rest_list
    case get_cart
    case get_product_list_by_filter
    case get_product_details
    case get_provider_review_rating
    case get_transaction
    case get_faq
    case get_user_order_by_status
    
    case add_to_cart_product
    case place_order
    case add_Payment_Wallet
//    case add_wallet_amount
    case add_rating_review_by_order
    case send_feedback
    
    case update_cart
    case like_unlike_product
    case fav_unfav_provider
    case update_profile
    
    case delete_cart_item
    
    public func url() -> String {
        switch self {
            
        case .login:
           return Router.oAuthpath(path: "login")
        case .signup:
            return Router.oAuthpath(path: "signup")
        case .verify_number:
            return Router.oAuthpath(path: "verify_number")
        case .forgot_password:
            return Router.oAuthpath(path: "forgot_password")
        case .change_password:
            return Router.oAuthpath(path: "change_password")
        case .social_login:
            return Router.oAuthpath(path: "social_login")
            
        case .get_profile:
            return Router.oAuthpath(path: "get_profile")
        case .get_Category:
            return Router.oAuthpath(path: "get_category")
        case .get_my_fav_product:
            return Router.oAuthpath(path: "get_my_fav_product")
        case .get_my_fav_provider:
            return Router.oAuthpath(path: "get_my_fav_provider")
        case .get_all_rest_list:
            return Router.oAuthpath(path: "get_all_rest_list")
        case .get_cart:
            return Router.oAuthpath(path: "get_cart")
        case .get_product_list_by_filter:
            return Router.oAuthpath(path: "get_product_list_by_filter")
        case .get_product_details:
            return Router.oAuthpath(path: "get_product_details")
        case .get_provider_review_rating:
            return Router.oAuthpath(path: "get_provider_review_rating")
        case .get_transaction:
            return Router.oAuthpath(path: "get_transaction")
        case .get_faq:
            return Router.oAuthpath(path: "get_faq")
        case .get_user_order_by_status:
            return Router.oAuthpath(path: "get_user_order_by_status")
            
        case .add_to_cart_product:
            return Router.oAuthpath(path: "add_to_cart_product")
        case .place_order:
            return Router.oAuthpath(path: "place_order")
        case .add_rating_review_by_order:
            return Router.oAuthpath(path: "add_rating_review_by_order")
            
        case .add_Payment_Wallet:
            if is_Navigate == "Order" {
                return Router.oAuthpath(path: "addPayment")
            } else {
                return Router.oAuthpath(path: "add_wallet_amount")
            }
            
        case .update_cart:
            return Router.oAuthpath(path: "update_cart")
        case .like_unlike_product:
            return Router.oAuthpath(path: "like_unlike_product")
        case .fav_unfav_provider:
            return Router.oAuthpath(path: "fav_unfav_provider")
        case .update_profile:
            return Router.oAuthpath(path: "update_profile")
            
        case .delete_cart_item:
            return Router.oAuthpath(path: "delete_cart_item")
     
        case .send_feedback:
            return Router.oAuthpath(path: "send_feedback")
        }
    }
    
    private static func oAuthpath(path: String) -> String {
        return Router.BASE_SERVICE_URl + path
    }
}
