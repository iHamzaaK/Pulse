//
//	CategoriesData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct CategoriesData : Codable {

	let child : [CategoriesChild]?
	let descriptionField : String?
	let icon : String?
	let id : Int?
	let image : String?
	let name : String?
	let parent : Int?
    let isQoute : Bool?
    let isVideo : Bool?


    enum CodingKeys: String, CodingKey {
            case child = "child"
            case descriptionField = "description"
            case icon = "icon"
            case id = "id"
            case image = "image"
            case isQoute = "isQoute"
            case isVideo = "isVideo"
            case name = "name"
            case parent = "parent"
        }
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		child = try values.decodeIfPresent([CategoriesChild].self, forKey: .child) ?? []
		descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField) ?? String()
		icon = try values.decodeIfPresent(String.self, forKey: .icon) ?? String()
		id = try values.decodeIfPresent(Int.self, forKey: .id) ?? Int()
		image = try values.decodeIfPresent(String.self, forKey: .image) ?? String()
		name = try values.decodeIfPresent(String.self, forKey: .name) ?? String()
		parent = try values.decodeIfPresent(Int.self, forKey: .parent) ?? Int()
                isVideo = try values.decodeIfPresent(Bool.self, forKey: .isVideo) ?? Bool()
                isQoute = try values.decodeIfPresent(Bool.self, forKey: .isQoute) ?? Bool()

	}
    


}
