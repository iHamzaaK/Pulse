//
//  Country.swift
//  Pulse
//
//  Created by Hamza Khan on 12.03.22.
//

import Foundation
struct Country : Codable {

  let title : String?
  let id : Int?
  
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case title = "title"

  }
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    id = try values.decodeIfPresent(Int.self, forKey: .id) ?? Int()
    title = try values.decodeIfPresent(String.self, forKey: .title) ?? String()

  }


}
