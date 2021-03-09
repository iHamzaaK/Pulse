//
//	AllLikesData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct AllLikesData : Codable {

	let name : String?
	let userImage : String?


	enum CodingKeys: String, CodingKey {
		case name = "name"
		case userImage = "user_image"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
		userImage = try values.decodeIfPresent(String.self, forKey: .userImage) ?? ""
	}


}
