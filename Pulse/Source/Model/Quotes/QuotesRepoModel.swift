//
//  QuotesRepoModel.swift
//  Pulse
//
//  Created by FraunhoferWork on 12/12/2020.
//

import Foundation
struct QuotesRepoModel : Codable {

    let quotes : [ArticleListingQuoteOfTheDay]?
    let statusCode : Int?
    let success : Bool?
    let message : String?

    enum CodingKeys: String, CodingKey {
        case quotes = "quotes"
        case statusCode = "statusCode"
        case success = "success"
        case message = "message"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        quotes = try values.decodeIfPresent([ArticleListingQuoteOfTheDay].self, forKey: .quotes) ?? []
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode) ?? Int()
        success = try values.decodeIfPresent(Bool.self, forKey: .success) ?? Bool()
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? String()
    }


}
