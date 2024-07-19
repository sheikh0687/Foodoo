//
//  Category.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 26/04/24.
//

import Foundation

struct Api_Category : Codable {

    let result : [Res_Category]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([Res_Category].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_Category : Codable {
    let id : String?
    let category_name : String?
    let image : String?
    let status : String?
    let date_time : String?
    let category_added : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case category_name = "category_name"
        case image = "image"
        case status = "status"
        case date_time = "date_time"
        case category_added = "category_added"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        category_name = try values.decodeIfPresent(String.self, forKey: .category_name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        category_added = try values.decodeIfPresent(String.self, forKey: .category_added)
    }
}
