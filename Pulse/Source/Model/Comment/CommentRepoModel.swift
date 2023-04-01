//
//  CommentRepoMoedl.swift
//  Pulse
//
//  Created by Hamza Khan on 21/12/2020.
//

import Foundation
struct CommentRepoModel : Codable {
  let data : [PostDetailComment]?
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
    data = try values.decodeIfPresent([PostDetailComment].self, forKey: .data)
    statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode)  ?? Int()
    success = try values.decodeIfPresent(Bool.self, forKey: .success) ?? false
    message = try values.decodeIfPresent(String.self, forKey: .message) ?? String()
  }
}
