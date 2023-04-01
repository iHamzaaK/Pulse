//
//	SearchRepo.swift
//	Created By Hamza Khan:  

import Foundation

struct SearchRepo : Codable {
  let data : [SearchData]?
  let statusCode : Int?
  let success : Bool?
  let totalPosts : Int?
  let message : String?

  enum CodingKeys: String, CodingKey {
    case data = "data"
    case statusCode = "statusCode"
    case success = "success"
    case totalPosts = "total_posts"
    case message = "message"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    data = try values.decodeIfPresent([SearchData].self, forKey: .data) ?? []
    statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode) ?? Int()
    success = try values.decodeIfPresent(Bool.self, forKey: .success) ?? Bool()
    totalPosts = try values.decodeIfPresent(Int.self, forKey: .totalPosts) ?? Int()
    message = try values.decodeIfPresent(String.self, forKey: .message) ?? String()
  }
}
