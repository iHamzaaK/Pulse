//
//	CategoriesChild.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct CategoriesChild : Codable {

	let descriptionField : String?
	let icon : String?
	let id : Int?
	let image : String?
	let name : String?
	let parent : Int?


	enum CodingKeys: String, CodingKey {
		case descriptionField = "description"
		case icon = "icon"
		case id = "id"
		case image = "image"
		case name = "name"
		case parent = "parent"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField) ?? String()
		icon = try values.decodeIfPresent(String.self, forKey: .icon) ?? String()
		id = try values.decodeIfPresent(Int.self, forKey: .id) ?? Int()
		image = try values.decodeIfPresent(String.self, forKey: .image) ?? String()
		name = try values.decodeIfPresent(String.self, forKey: .name) ?? String()
		parent = try values.decodeIfPresent(Int.self, forKey: .parent) ?? Int()
	}


}
