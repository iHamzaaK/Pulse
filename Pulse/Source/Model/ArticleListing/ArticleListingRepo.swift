//
//	ArticleListingRepo.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct ArticleListingRepoModel : Codable {

	let data : [ArticleListingData]?
	let maxNumPages : Int?
//	let quoteOfTheDay : [ArticleListingQuoteOfTheDay]?
	let statusCode : Int?
	let success : Bool?
	let totalPosts : Int?
    let message : String

	enum CodingKeys: String, CodingKey {
		case data = "data"
		case maxNumPages = "max_num_pages"
//		case quoteOfTheDay = "quote_of_the_day"
		case statusCode = "statusCode"
		case success = "success"
		case totalPosts = "total_posts"
        case message = "message"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		data = try values.decodeIfPresent([ArticleListingData].self, forKey: .data) ?? []
		maxNumPages = try values.decodeIfPresent(Int.self, forKey: .maxNumPages) ?? Int()
//		quoteOfTheDay = try values.decodeIfPresent([ArticleListingQuoteOfTheDay].self, forKey: .quoteOfTheDay) ?? []
		statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode)  ?? Int()
		success = try values.decodeIfPresent(Bool.self, forKey: .success) ?? false
		totalPosts = try values.decodeIfPresent(Int.self, forKey: .totalPosts) ?? Int()
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? String()

	}


}
