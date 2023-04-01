//
//	CategoriesRepoModel.swift
//	Created By Hamza Khan:  

import Foundation

struct CategoriesRepoModel : Codable {
  let data : [CategoriesData]?
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
    data = try values.decodeIfPresent([CategoriesData].self, forKey: .data) ?? []
    statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode) ?? 401
    success = try values.decodeIfPresent(Bool.self, forKey: .success) ?? false
    message = try values.decodeIfPresent(String.self, forKey: .message) ?? ""

  }
}
