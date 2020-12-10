//
//	PostDetailData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct PostDetailData : Codable {

	let daysAgo : String?
	let descriptionField : String?
	let id : String?
	let isBookmarked : Bool?
	let isLiked : Bool?
	let isVideo : Bool?
	let likeCount : Int?
	let permalink : String?
	let shortDescription : String?
	let tag : String?
	let thumbnail : String?
	let title : String?
	let videoUrl : String?


	enum CodingKeys: String, CodingKey {
		case daysAgo = "days_ago"
		case descriptionField = "description"
		case id = "id"
		case isBookmarked = "is_bookmarked"
		case isLiked = "is_liked"
		case isVideo = "is_video"
		case likeCount = "like_count"
		case permalink = "permalink"
		case shortDescription = "short_description"
		case tag = "tag"
		case thumbnail = "thumbnail"
		case title = "title"
		case videoUrl = "video_url"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		daysAgo = try values.decodeIfPresent(String.self, forKey: .daysAgo) ?? String()
		descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField) ?? String()
		id = try values.decodeIfPresent(String.self, forKey: .id) ?? String()
		isBookmarked = try values.decodeIfPresent(Bool.self, forKey: .isBookmarked) ?? Bool()
		isLiked = try values.decodeIfPresent(Bool.self, forKey: .isLiked) ?? Bool()
		isVideo = try values.decodeIfPresent(Bool.self, forKey: .isVideo) ?? Bool()
		likeCount = try values.decodeIfPresent(Int.self, forKey: .likeCount)  ?? Int()
		permalink = try values.decodeIfPresent(String.self, forKey: .permalink)  ?? String()
		shortDescription = try values.decodeIfPresent(String.self, forKey: .shortDescription) ?? String()
		tag = try values.decodeIfPresent(String.self, forKey: .tag) ?? String()
		thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail) ?? String()
		title = try values.decodeIfPresent(String.self, forKey: .title) ?? String()
		videoUrl = try values.decodeIfPresent(String.self, forKey: .videoUrl) ?? String()
	}


}
