//
//	ArticleListingQuoteOfTheDay.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct ArticleListingQuoteOfTheDay : Codable {

	let descriptionField : String?
	let id : Int?
	let isVideo : Bool?
	let permalink : String?
	let thumbnail : String?
	let title : String?
	let videoUrl : String?


	enum CodingKeys: String, CodingKey {
		case descriptionField = "description"
		case id = "id"
		case isVideo = "is_video"
		case permalink = "permalink"
		case thumbnail = "thumbnail"
		case title = "title"
		case videoUrl = "video_url"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField) ?? String()
		id = try values.decodeIfPresent(Int.self, forKey: .id) ?? Int()
		isVideo = try values.decodeIfPresent(Bool.self, forKey: .isVideo) ?? Bool()
		permalink = try values.decodeIfPresent(String.self, forKey: .permalink) ?? String()
		thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail) ?? String()
		title = try values.decodeIfPresent(String.self, forKey: .title) ?? String()
		videoUrl = try values.decodeIfPresent(String.self, forKey: .videoUrl) ?? String()
	}


}
