//
//	PostDetailComment.swift
//	Created By Hamza Khan:  

import Foundation

struct PostDetailComment : Codable {
  let avatar : String?
  let commentAuthor : String?
  let commentContent : String?
  let daysAgo : String?
  let id : Int?

  enum CodingKeys: String, CodingKey {
    case avatar = "avatar"
    case commentAuthor = "comment_author"
    case commentContent = "comment_content"
    case daysAgo = "days_ago"
    case id = "id"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    avatar = try values.decodeIfPresent(String.self, forKey: .avatar) ?? String()
    commentAuthor = try values.decodeIfPresent(String.self, forKey: .commentAuthor) ?? String()
    commentContent = try values.decodeIfPresent(String.self, forKey: .commentContent) ?? String()
    daysAgo = try values.decodeIfPresent(String.self, forKey: .daysAgo) ?? String()
    id = try values.decodeIfPresent(Int.self, forKey: .id) ?? Int()
  }


}
