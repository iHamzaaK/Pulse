//
//	PostDetailRepo.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct PostDetailRepo : Codable {

	let comments : [PostDetailComment]?
	let data : [PostDetailData]?
	let statusCode : Int?
	let success : Bool?
    let message : String?

	enum CodingKeys: String, CodingKey {
		case comments = "comments"
		case data = "data"
		case statusCode = "statusCode"
		case success = "success"
        case message = "message"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		comments = try values.decodeIfPresent([PostDetailComment].self, forKey: .comments) ?? []
		data = try values.decodeIfPresent([PostDetailData].self, forKey: .data) ?? []
		statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode) ?? Int()
		success = try values.decodeIfPresent(Bool.self, forKey: .success) ?? Bool()
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? String()

	}


}
