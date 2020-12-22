//
//  PolicyRepoModel.swift
//  Pulse
//
//  Created by FraunhoferWork on 19/12/2020.
//

import Foundation
struct PolicyRepoModel : Codable {

    let data : ArticleListingData?
    let statusCode : Int?
    let success : Bool?
    let message : String


    enum CodingKeys: String, CodingKey {
        case data = "data"
        case statusCode = "statusCode"
        case success = "success"
        case message = "message"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(ArticleListingData.self, forKey: .data)
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode)  ?? Int()
        success = try values.decodeIfPresent(Bool.self, forKey: .success) ?? false
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? String()
    }


}
