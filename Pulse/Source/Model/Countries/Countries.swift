//
//  Countries.swift
//  Pulse
//
//  Created by Hamza Khan on 12.03.22.
//

import Foundation
//{
//  "data": [
//    {
//      "id": 19606,
//      "title": "Saudia Arabia"
//    },
//    {
//      "id": 19605,
//      "title": "United Arab Emirates"
//    }
//  ],
//  "success": true,
//  "statusCode": 200
//}
struct Countries : Codable {

  let data : [Country]?
  let success : Bool?
  let message : String?
  let statusCode : Int?


  enum CodingKeys: String, CodingKey {
    case data = "data"
    case statusCode = "statusCode"
    case success = "success"
    case message = "message"
  }
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    data = try values.decodeIfPresent([Country].self, forKey: .data) ?? []
    statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode)  ?? Int()
    success = try values.decodeIfPresent(Bool.self, forKey: .success) ?? false
    message = try values.decodeIfPresent(String.self, forKey: .message) ?? String()
  }


}
