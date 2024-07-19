//
//  Faqs.swift
//  Foodoo
//
//  Created by Techimmense Software Solutions on 03/05/24.
//

import Foundation

struct Api_FAQs : Codable {
    let result : [Res_FAQs]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([Res_FAQs].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_FAQs : Codable {
    let id : String?
    let question : String?
    let answer : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case question = "question"
        case answer = "answer"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        question = try values.decodeIfPresent(String.self, forKey: .question)
        answer = try values.decodeIfPresent(String.self, forKey: .answer)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }
}
