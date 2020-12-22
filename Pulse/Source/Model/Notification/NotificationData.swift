//
//	NotificationData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct NotificationData : Codable {

	let articleId : Int?
	let noOfComments : Int?
	let notificationId : Int?
	let tag : String?
	let title : String?


	enum CodingKeys: String, CodingKey {
		case articleId = "article_id"
		case noOfComments = "no_of_comments"
		case notificationId = "notification_id"
		case tag = "tag"
		case title = "title"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		articleId = try values.decodeIfPresent(Int.self, forKey: .articleId)
		noOfComments = try values.decodeIfPresent(Int.self, forKey: .noOfComments)
		notificationId = try values.decodeIfPresent(Int.self, forKey: .notificationId)
		tag = try values.decodeIfPresent(String.self, forKey: .tag)
		title = try values.decodeIfPresent(String.self, forKey: .title)
	}


}