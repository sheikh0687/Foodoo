//
//  Reviews.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 29/04/24.
//

import Foundation

struct Api_Reviews : Codable {
    let result : [Res_Reviews]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([Res_Reviews].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_Reviews : Codable {
    let id : String?
    let request_id : String?
    let provider_id : String?
    let user_id : String?
    let driver_id : String?
    let rating : String?
    let review : String?
    let date_time : String?
    let type : String?
    let user_name : String?
    let image : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case request_id = "request_id"
        case provider_id = "provider_id"
        case user_id = "user_id"
        case driver_id = "driver_id"
        case rating = "rating"
        case review = "review"
        case date_time = "date_time"
        case type = "type"
        case user_name = "user_name"
        case image = "image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        request_id = try values.decodeIfPresent(String.self, forKey: .request_id)
        provider_id = try values.decodeIfPresent(String.self, forKey: .provider_id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        driver_id = try values.decodeIfPresent(String.self, forKey: .driver_id)
        rating = try values.decodeIfPresent(String.self, forKey: .rating)
        review = try values.decodeIfPresent(String.self, forKey: .review)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        user_name = try values.decodeIfPresent(String.self, forKey: .user_name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }
}
