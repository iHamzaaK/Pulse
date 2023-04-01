//
//	SearchData.swift
//	Created By Hamza Khan:  

import Foundation

struct SearchData : Codable {
  let id : String?
  let title : String?

  enum CodingKeys: String, CodingKey {
    case id = "id"
    case title = "title"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    id = try values.decodeIfPresent(String.self, forKey: .id)  ?? String()
    title = try values.decodeIfPresent(String.self, forKey: .title) ?? String()
  }
}
