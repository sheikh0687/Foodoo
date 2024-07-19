//
//  AllCart.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 26/04/24.
//

import Foundation

struct Api_Cart : Codable {
    let cart_total_amount : String?
    let discount_amount : String?
    let service_fee : String?
    let total_tax : String?
    let sub_total_amount : String?
    
    
    let before_discount_amount : String?
    let total_discount_amount : String?
    let total_cart : String?
    let total_amount : String?
    let delivery_fee : String?
    let result : [Res_CartDt]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {
        
        case cart_total_amount = "cart_total_amount"
        case discount_amount = "discount_amount"
        case service_fee = "service_fee"
        case total_tax = "total_tax"
        case sub_total_amount = "sub_total_amount"
        
        case before_discount_amount = "before_discount_amount"
        case total_discount_amount = "total_discount_amount"
        case total_cart = "total_cart"
        case delivery_fee = "delivery_fee"
        case total_amount = "total_amount"
        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        total_amount = try values.decodeIfPresent(String.self, forKey: .total_amount)
        before_discount_amount = try values.decodeIfPresent(String.self, forKey: .before_discount_amount)
        total_discount_amount = try values.decodeIfPresent(String.self, forKey: .total_discount_amount)
        total_cart = try values.decodeIfPresent(String.self, forKey: .total_cart)
        delivery_fee = try values.decodeIfPresent(String.self, forKey: .delivery_fee)
        
        cart_total_amount = try values.decodeIfPresent(String.self, forKey: .cart_total_amount)
        discount_amount = try values.decodeIfPresent(String.self, forKey: .discount_amount)
        service_fee = try values.decodeIfPresent(String.self, forKey: .service_fee)
        total_tax = try values.decodeIfPresent(String.self, forKey: .total_tax)
        sub_total_amount = try values.decodeIfPresent(String.self, forKey: .sub_total_amount)
        
        result = try values.decodeIfPresent([Res_CartDt].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_CartDt : Codable {
    let id : String?
    let user_id : String?
    let cat_id : String?
    let provider_id : String?
    let product_id : String?
    let product_name : String?
    let product_price : String?
    let quantity : String?
    let size_id : String?
    let size_name : String?
    let size_price : String?
    let cat_name : String?
    let extra_item_id : String?
    let extra_item_name : String?
    let extra_item_price : String?
    let extra_item_qty : String?
    let total_amount : String?
    let total_extra_item_price : String?
    let before_discount_amount : String?
    let after_discount_amount : String?
    let discount_amount : String?
    let offer_id : String?
    let status : String?
    let offer_apply_status : String?
    let date_time : String?
    let product_details : Product_details?
    let rest_details : Rest_details?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case cat_id = "cat_id"
        case provider_id = "provider_id"
        case product_id = "product_id"
        case product_name = "product_name"
        case product_price = "product_price"
        case quantity = "quantity"
        case size_id = "size_id"
        case size_name = "size_name"
        case size_price = "size_price"
        case cat_name = "cat_name"
        case extra_item_id = "extra_item_id"
        case extra_item_name = "extra_item_name"
        case extra_item_price = "extra_item_price"
        case extra_item_qty = "extra_item_qty"
        case total_amount = "total_amount"
        case total_extra_item_price = "total_extra_item_price"
        case before_discount_amount = "before_discount_amount"
        case after_discount_amount = "after_discount_amount"
        case discount_amount = "discount_amount"
        case offer_id = "offer_id"
        case status = "status"
        case offer_apply_status = "offer_apply_status"
        case date_time = "date_time"
        case product_details = "product_details"
        case rest_details = "rest_details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        cat_id = try values.decodeIfPresent(String.self, forKey: .cat_id)
        provider_id = try values.decodeIfPresent(String.self, forKey: .provider_id)
        product_id = try values.decodeIfPresent(String.self, forKey: .product_id)
        product_name = try values.decodeIfPresent(String.self, forKey: .product_name)
        product_price = try values.decodeIfPresent(String.self, forKey: .product_price)
        quantity = try values.decodeIfPresent(String.self, forKey: .quantity)
        size_id = try values.decodeIfPresent(String.self, forKey: .size_id)
        size_name = try values.decodeIfPresent(String.self, forKey: .size_name)
        size_price = try values.decodeIfPresent(String.self, forKey: .size_price)
        cat_name = try values.decodeIfPresent(String.self, forKey: .cat_name)
        extra_item_id = try values.decodeIfPresent(String.self, forKey: .extra_item_id)
        extra_item_name = try values.decodeIfPresent(String.self, forKey: .extra_item_name)
        extra_item_price = try values.decodeIfPresent(String.self, forKey: .extra_item_price)
        extra_item_qty = try values.decodeIfPresent(String.self, forKey: .extra_item_qty)
        total_amount = try values.decodeIfPresent(String.self, forKey: .total_amount)
        total_extra_item_price = try values.decodeIfPresent(String.self, forKey: .total_extra_item_price)
        before_discount_amount = try values.decodeIfPresent(String.self, forKey: .before_discount_amount)
        after_discount_amount = try values.decodeIfPresent(String.self, forKey: .after_discount_amount)
        discount_amount = try values.decodeIfPresent(String.self, forKey: .discount_amount)
        offer_id = try values.decodeIfPresent(String.self, forKey: .offer_id)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        offer_apply_status = try values.decodeIfPresent(String.self, forKey: .offer_apply_status)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        product_details = try values.decodeIfPresent(Product_details.self, forKey: .product_details)
        rest_details = try values.decodeIfPresent(Rest_details.self, forKey: .rest_details)
    }
}

struct Product_details : Codable {
    let id : String?
    let provider_id : String?
    let cat_id : String?
    let cat_name : String?
    let item_name : String?
    let item_price : String?
    let offer_item_price : String?
    let item_description : String?
    let item_quantity : String?
    let bag_size_id : String?
    let bag_size_name : String?
    let bag_size_price : String?
    let type : String?
    let available_status : String?
    let date_time : String?
    let remove_status : String?
    let product_images : [Product_images]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case provider_id = "provider_id"
        case cat_id = "cat_id"
        case cat_name = "cat_name"
        case item_name = "item_name"
        case item_price = "item_price"
        case offer_item_price = "offer_item_price"
        case item_description = "item_description"
        case item_quantity = "item_quantity"
        case bag_size_id = "bag_size_id"
        case bag_size_name = "bag_size_name"
        case bag_size_price = "bag_size_price"
        case type = "type"
        case available_status = "available_status"
        case date_time = "date_time"
        case remove_status = "remove_status"
        case product_images = "product_images"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        provider_id = try values.decodeIfPresent(String.self, forKey: .provider_id)
        cat_id = try values.decodeIfPresent(String.self, forKey: .cat_id)
        cat_name = try values.decodeIfPresent(String.self, forKey: .cat_name)
        item_name = try values.decodeIfPresent(String.self, forKey: .item_name)
        item_price = try values.decodeIfPresent(String.self, forKey: .item_price)
        offer_item_price = try values.decodeIfPresent(String.self, forKey: .offer_item_price)
        item_description = try values.decodeIfPresent(String.self, forKey: .item_description)
        item_quantity = try values.decodeIfPresent(String.self, forKey: .item_quantity)
        bag_size_id = try values.decodeIfPresent(String.self, forKey: .bag_size_id)
        bag_size_name = try values.decodeIfPresent(String.self, forKey: .bag_size_name)
        bag_size_price = try values.decodeIfPresent(String.self, forKey: .bag_size_price)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        available_status = try values.decodeIfPresent(String.self, forKey: .available_status)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        remove_status = try values.decodeIfPresent(String.self, forKey: .remove_status)
        product_images = try values.decodeIfPresent([Product_images].self, forKey: .product_images)
    }
}


struct Product_images : Codable {
    let id : String?
    let product_id : String?
    let image : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case product_id = "product_id"
        case image = "image"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        product_id = try values.decodeIfPresent(String.self, forKey: .product_id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }

}
