//
//  FavrouiteProduct.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 26/04/24.
//

import Foundation

struct Api_FavProducts : Codable {
    let result : [Res_FavProduct]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([Res_FavProduct].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_FavProduct : Codable {
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
    let product_like : String?
    let rest_details : Rest_details?

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
        case product_like = "product_like"
        case rest_details = "rest_details"
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
        product_like = try values.decodeIfPresent(String.self, forKey: .product_like)
        rest_details = try values.decodeIfPresent(Rest_details.self, forKey: .rest_details)
    }
}

struct Rest_details : Codable {
    let id : String?
    let first_name : String?
    let last_name : String?
    let mobile : String?
    let mobile_with_code : String?
    let email : String?
    let password : String?
    let country_id : String?
    let country_name : String?
    let state_id : String?
    let state_name : String?
    let city_id : String?
    let city_name : String?
    let image : String?
    let type : String?
    let social_id : String?
    let lat : String?
    let lon : String?
    let address : String?
    let address_id : String?
    let gender : String?
    let wallet : String?
    let register_id : String?
    let ios_register_id : String?
    let status : String?
    let approve_status : String?
    let available_status : String?
    let code : String?
    let date_time : String?
    let note : String?
    let note_block : String?
    let block_unblock : String?
    let remove_status : String?
    let open_time : String?
    let close_time : String?
    let store_ope_closs_status : String?
    let referral_code : String?
    let signup_referral_code : String?
    let provider_name : String?
    let provider_email : String?
    let provider_mobile : String?
    let provider_streat_address : String?
    let provider_lat : String?
    let provider_lon : String?
    let provider_post_code : String?
    let provider_country : String?
    let provider_country_id : String?
    let facebook_url : String?
    let instagram_url : String?
    let description : String?
    let delivery_option : String?
    let provider_logo : String?
    let radius : String?
    let cat_id : String?
    let cat_name : String?
    let distance : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case first_name = "first_name"
        case last_name = "last_name"
        case mobile = "mobile"
        case mobile_with_code = "mobile_with_code"
        case email = "email"
        case password = "password"
        case country_id = "country_id"
        case country_name = "country_name"
        case state_id = "state_id"
        case state_name = "state_name"
        case city_id = "city_id"
        case city_name = "city_name"
        case image = "image"
        case type = "type"
        case social_id = "social_id"
        case lat = "lat"
        case lon = "lon"
        case address = "address"
        case address_id = "address_id"
        case gender = "gender"
        case wallet = "wallet"
        case register_id = "register_id"
        case ios_register_id = "ios_register_id"
        case status = "status"
        case approve_status = "approve_status"
        case available_status = "available_status"
        case code = "code"
        case date_time = "date_time"
        case note = "note"
        case note_block = "note_block"
        case block_unblock = "block_unblock"
        case remove_status = "remove_status"
        case open_time = "open_time"
        case close_time = "close_time"
        case store_ope_closs_status = "store_ope_closs_status"
        case referral_code = "referral_code"
        case signup_referral_code = "signup_referral_code"
        case provider_name = "provider_name"
        case provider_email = "provider_email"
        case provider_mobile = "provider_mobile"
        case provider_streat_address = "provider_streat_address"
        case provider_lat = "provider_lat"
        case provider_lon = "provider_lon"
        case provider_post_code = "provider_post_code"
        case provider_country = "provider_country"
        case provider_country_id = "provider_country_id"
        case facebook_url = "facebook_url"
        case instagram_url = "instagram_url"
        case description = "description"
        case delivery_option = "delivery_option"
        case provider_logo = "provider_logo"
        case radius = "radius"
        case cat_id = "cat_id"
        case cat_name = "cat_name"
        case distance = "distance"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        mobile_with_code = try values.decodeIfPresent(String.self, forKey: .mobile_with_code)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        country_id = try values.decodeIfPresent(String.self, forKey: .country_id)
        country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
        state_id = try values.decodeIfPresent(String.self, forKey: .state_id)
        state_name = try values.decodeIfPresent(String.self, forKey: .state_name)
        city_id = try values.decodeIfPresent(String.self, forKey: .city_id)
        city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        social_id = try values.decodeIfPresent(String.self, forKey: .social_id)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        address_id = try values.decodeIfPresent(String.self, forKey: .address_id)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        wallet = try values.decodeIfPresent(String.self, forKey: .wallet)
        register_id = try values.decodeIfPresent(String.self, forKey: .register_id)
        ios_register_id = try values.decodeIfPresent(String.self, forKey: .ios_register_id)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        approve_status = try values.decodeIfPresent(String.self, forKey: .approve_status)
        available_status = try values.decodeIfPresent(String.self, forKey: .available_status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        note = try values.decodeIfPresent(String.self, forKey: .note)
        note_block = try values.decodeIfPresent(String.self, forKey: .note_block)
        block_unblock = try values.decodeIfPresent(String.self, forKey: .block_unblock)
        remove_status = try values.decodeIfPresent(String.self, forKey: .remove_status)
        open_time = try values.decodeIfPresent(String.self, forKey: .open_time)
        close_time = try values.decodeIfPresent(String.self, forKey: .close_time)
        store_ope_closs_status = try values.decodeIfPresent(String.self, forKey: .store_ope_closs_status)
        referral_code = try values.decodeIfPresent(String.self, forKey: .referral_code)
        signup_referral_code = try values.decodeIfPresent(String.self, forKey: .signup_referral_code)
        provider_name = try values.decodeIfPresent(String.self, forKey: .provider_name)
        provider_email = try values.decodeIfPresent(String.self, forKey: .provider_email)
        provider_mobile = try values.decodeIfPresent(String.self, forKey: .provider_mobile)
        provider_streat_address = try values.decodeIfPresent(String.self, forKey: .provider_streat_address)
        provider_lat = try values.decodeIfPresent(String.self, forKey: .provider_lat)
        provider_lon = try values.decodeIfPresent(String.self, forKey: .provider_lon)
        provider_post_code = try values.decodeIfPresent(String.self, forKey: .provider_post_code)
        provider_country = try values.decodeIfPresent(String.self, forKey: .provider_country)
        provider_country_id = try values.decodeIfPresent(String.self, forKey: .provider_country_id)
        facebook_url = try values.decodeIfPresent(String.self, forKey: .facebook_url)
        instagram_url = try values.decodeIfPresent(String.self, forKey: .instagram_url)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        delivery_option = try values.decodeIfPresent(String.self, forKey: .delivery_option)
        provider_logo = try values.decodeIfPresent(String.self, forKey: .provider_logo)
        radius = try values.decodeIfPresent(String.self, forKey: .radius)
        cat_id = try values.decodeIfPresent(String.self, forKey: .cat_id)
        cat_name = try values.decodeIfPresent(String.self, forKey: .cat_name)
        distance = try values.decodeIfPresent(String.self, forKey: .distance)
    }

}
