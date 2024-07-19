//
//  PlaceOrder.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 03/05/24.
//

import Foundation

struct Api_PlacedOrder : Codable {
    let result : Res_PlaceOrder?
    let status : String?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case status = "status"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(Res_PlaceOrder.self, forKey: .result)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
}

struct Res_PlaceOrder : Codable {
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
    }

}
