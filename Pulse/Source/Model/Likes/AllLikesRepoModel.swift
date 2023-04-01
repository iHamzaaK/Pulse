//
//	AllLikesRepoModel.swift
//	Created By Hamza Khan:  

import Foundation

struct AllLikesRepoModel : Codable {
  let data : [AllLikesData]?
  let noOfLikes : Int?
  let statusCode : Int?
  let success : Bool?
  let message : String

  enum CodingKeys: String, CodingKey {
    case data = "data"
    case noOfLikes = "no_of_likes"
    case statusCode = "statusCode"
    case success = "success"
    case message = "message"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    data = try values.decodeIfPresent([AllLikesData].self, forKey: .data) ?? []
    noOfLikes = try values.decodeIfPresent(Int.self, forKey: .noOfLikes) ?? Int()
    statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode) ?? Int()
    success = try values.decodeIfPresent(Bool.self, forKey: .success) ?? false
    message = try values.decodeIfPresent(String.self, forKey: .message) ?? String()
  }
}
