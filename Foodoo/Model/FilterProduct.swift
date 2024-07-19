//
//  FilterProduct.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 27/04/24.
//

import Foundation

struct Api_FilterProduct : Codable {
    let result : [Res_FilterProduct]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([Res_FilterProduct].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_FilterProduct : Codable {
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
    let rest_details : Rest_details?
    let product_images : [Product_images]?
    let product_additional : [Product_additional]?
    let distance : String?

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
        case rest_details = "rest_details"
        case product_images = "product_images"
        case product_additional = "product_additional"
        case distance = "distance"
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
        rest_details = try values.decodeIfPresent(Rest_details.self, forKey: .rest_details)
        product_images = try values.decodeIfPresent([Product_images].self, forKey: .product_images)
        product_additional = try values.decodeIfPresent([Product_additional].self, forKey: .product_additional)
        distance = try values.decodeIfPresent(String.self, forKey: .distance)
    }
}

struct Product_additional : Codable {
    let id : String?
    let product_id : String?
    let item_name : String?
    let item_price : String?
    let extra_item_image : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case product_id = "product_id"
        case item_name = "item_name"
        case item_price = "item_price"
        case extra_item_image = "extra_item_image"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        product_id = try values.decodeIfPresent(String.self, forKey: .product_id)
        item_name = try values.decodeIfPresent(String.self, forKey: .item_name)
        item_price = try values.decodeIfPresent(String.self, forKey: .item_price)
        extra_item_image = try values.decodeIfPresent(String.self, forKey: .extra_item_image)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }

}
