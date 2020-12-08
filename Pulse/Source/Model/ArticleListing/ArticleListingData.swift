//
//	ArticleListingData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct ArticleListingData : Codable {

	let descriptionField : String?
	let id : Int?
	let isVideo : Bool?
	let permalink : String?
	let thumbnail : String?
	let title : String?
    let videoUrl : String?
    let shortDescription: String
    let date : String
    let tag : String
    let isBookmarked : Bool
    let isLiked : Bool
    let likeCount : Int

	enum CodingKeys: String, CodingKey {
		case descriptionField = "description"
		case id = "id"
		case isVideo = "is_video"
		case permalink = "permalink"
		case thumbnail = "thumbnail"
		case title = "title"
		case videoUrl = "video_url"
        case shortDescription = "short_description"
        case date = "days_ago"
        case tag = "tag"
        case isBookmarked = "is_bookmarked"
        case isLiked = "is_liked"
        case likeCount = "like_count"

	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField) ?? String()
		id = try values.decodeIfPresent(Int.self, forKey: .id) ?? Int()
		isVideo = try values.decodeIfPresent(Bool.self, forKey: .isVideo) ?? Bool()
		permalink = try values.decodeIfPresent(String.self, forKey: .permalink) ?? String()
		thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail) ?? String()
		title = try values.decodeIfPresent(String.self, forKey: .title) ?? String()
        
		videoUrl = ""//try values.decodeIfPresent(String.self, forKey: .videoUrl) ?? String()
        shortDescription = try values.decodeIfPresent(String.self, forKey: .shortDescription) ?? String()
        date = try values.decodeIfPresent(String.self, forKey: .date) ?? String()
        tag = try values.decodeIfPresent(String.self, forKey: .tag) ?? String()
        isBookmarked = try values.decodeIfPresent(Bool.self, forKey: .isBookmarked) ?? Bool()
        isLiked = try values.decodeIfPresent(Bool.self, forKey: .isLiked) ?? Bool()
        likeCount = try values.decodeIfPresent(Int.self, forKey: .likeCount) ?? Int()
        
	}


}
