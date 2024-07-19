//
//  OrderStatus.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 03/05/24.
//

import Foundation

struct Api_OrderStatus : Codable {
    let result : [Res_OrderStatus]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([Res_OrderStatus].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_OrderStatus : Codable {
    let id : String?
    let user_id : String?
    let provider_id : String?
    let cart_id : String?
    let address_id : String?
    let order_id : String?
    let total_amount : String?
    let save_money : String?
    let co2e : String?
    let before_discount_amount : String?
    let total_discount_amount : String?
    let delivery_date : String?
    let delivery_time : String?
    let date_time : String?
    let status : String?
    let delivery_status : String?
    let payment_status : String?
    let payment_method : String?
    let driver_id : String?
    let accept_driver_id : String?
    let remove_status : String?
    let order_ready_time : String?
    let delivery_fee : String?
    let sub_total : String?
    let driver_del_fee : String?
    let admin_com_fee : String?
    let delivery_type : String?
    let date : String?
    let time : String?
    let offer_id : String?
    let offer_code : String?
    let cart_details : [Cart_details]?
    let address_details : Address_details?
    let product_details : [Product_details]?
    let rest_details : Rest_details?
    let rating_review : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case provider_id = "provider_id"
        case cart_id = "cart_id"
        case address_id = "address_id"
        case order_id = "order_id"
        case total_amount = "total_amount"
        case save_money = "save_money"
        case co2e = "co2e"
        case before_discount_amount = "before_discount_amount"
        case total_discount_amount = "total_discount_amount"
        case delivery_date = "delivery_date"
        case delivery_time = "delivery_time"
        case date_time = "date_time"
        case status = "status"
        case delivery_status = "delivery_status"
        case payment_status = "payment_status"
        case payment_method = "payment_method"
        case driver_id = "driver_id"
        case accept_driver_id = "accept_driver_id"
        case remove_status = "remove_status"
        case order_ready_time = "order_ready_time"
        case delivery_fee = "delivery_fee"
        case sub_total = "sub_total"
        case driver_del_fee = "driver_del_fee"
        case admin_com_fee = "admin_com_fee"
        case delivery_type = "delivery_type"
        case date = "date"
        case time = "time"
        case offer_id = "offer_id"
        case offer_code = "offer_code"
        case cart_details = "cart_details"
        case address_details = "address_details"
        case product_details = "product_details"
        case rest_details = "rest_details"
        case rating_review = "rating_review"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        provider_id = try values.decodeIfPresent(String.self, forKey: .provider_id)
        cart_id = try values.decodeIfPresent(String.self, forKey: .cart_id)
        address_id = try values.decodeIfPresent(String.self, forKey: .address_id)
        order_id = try values.decodeIfPresent(String.self, forKey: .order_id)
        total_amount = try values.decodeIfPresent(String.self, forKey: .total_amount)
        save_money = try values.decodeIfPresent(String.self, forKey: .save_money)
        co2e = try values.decodeIfPresent(String.self, forKey: .co2e)
        before_discount_amount = try values.decodeIfPresent(String.self, forKey: .before_discount_amount)
        total_discount_amount = try values.decodeIfPresent(String.self, forKey: .total_discount_amount)
        delivery_date = try values.decodeIfPresent(String.self, forKey: .delivery_date)
        delivery_time = try values.decodeIfPresent(String.self, forKey: .delivery_time)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        delivery_status = try values.decodeIfPresent(String.self, forKey: .delivery_status)
        payment_status = try values.decodeIfPresent(String.self, forKey: .payment_status)
        payment_method = try values.decodeIfPresent(String.self, forKey: .payment_method)
        driver_id = try values.decodeIfPresent(String.self, forKey: .driver_id)
        accept_driver_id = try values.decodeIfPresent(String.self, forKey: .accept_driver_id)
        remove_status = try values.decodeIfPresent(String.self, forKey: .remove_status)
        order_ready_time = try values.decodeIfPresent(String.self, forKey: .order_ready_time)
        delivery_fee = try values.decodeIfPresent(String.self, forKey: .delivery_fee)
        sub_total = try values.decodeIfPresent(String.self, forKey: .sub_total)
        driver_del_fee = try values.decodeIfPresent(String.self, forKey: .driver_del_fee)
        admin_com_fee = try values.decodeIfPresent(String.self, forKey: .admin_com_fee)
        delivery_type = try values.decodeIfPresent(String.self, forKey: .delivery_type)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        time = try values.decodeIfPresent(String.self, forKey: .time)
        offer_id = try values.decodeIfPresent(String.self, forKey: .offer_id)
        offer_code = try values.decodeIfPresent(String.self, forKey: .offer_code)
        cart_details = try values.decodeIfPresent([Cart_details].self, forKey: .cart_details)
        address_details = try values.decodeIfPresent(Address_details.self, forKey: .address_details)
        product_details = try values.decodeIfPresent([Product_details].self, forKey: .product_details)
        rest_details = try values.decodeIfPresent(Rest_details.self, forKey: .rest_details)
        rating_review = try values.decodeIfPresent(String.self, forKey: .rating_review)
    }
}

struct Cart_details : Codable {
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
    let save_money : String?
    let co2e : String?
    let total_extra_item_price : String?
    let before_discount_amount : String?
    let after_discount_amount : String?
    let discount_amount : String?
    let offer_id : String?
    let status : String?
    let offer_apply_status : String?
    let date_time : String?

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
        case save_money = "save_money"
        case co2e = "co2e"
        case total_extra_item_price = "total_extra_item_price"
        case before_discount_amount = "before_discount_amount"
        case after_discount_amount = "after_discount_amount"
        case discount_amount = "discount_amount"
        case offer_id = "offer_id"
        case status = "status"
        case offer_apply_status = "offer_apply_status"
        case date_time = "date_time"
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
        save_money = try values.decodeIfPresent(String.self, forKey: .save_money)
        co2e = try values.decodeIfPresent(String.self, forKey: .co2e)
        total_extra_item_price = try values.decodeIfPresent(String.self, forKey: .total_extra_item_price)
        before_discount_amount = try values.decodeIfPresent(String.self, forKey: .before_discount_amount)
        after_discount_amount = try values.decodeIfPresent(String.self, forKey: .after_discount_amount)
        discount_amount = try values.decodeIfPresent(String.self, forKey: .discount_amount)
        offer_id = try values.decodeIfPresent(String.self, forKey: .offer_id)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        offer_apply_status = try values.decodeIfPresent(String.self, forKey: .offer_apply_status)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }

}

struct Address_details : Codable {}
