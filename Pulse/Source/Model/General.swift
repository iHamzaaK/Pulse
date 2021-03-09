//
//  General.swift
//  Pulse
//
//  Created by Hamza Khan on 01/12/2020.
//

import Foundation
import Foundation

class GeneralRepoModel : Codable {
    let success : Bool?
    let statusCode : Int?
    let message : String?


    enum CodingKeys: String, CodingKey {
        case statusCode = "statusCode"
        case message = "message"
        case success = "success"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode) ?? Int()
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? String()
        success = try values.decodeIfPresent(Bool.self, forKey: .success) ?? Bool()
    }


}
