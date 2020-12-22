//
//	NotificationRepoModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct NotificationRepoModel : Codable {

	let data : [NotificationData]?
	let noOfNotification : Int?
	let statusCode : Int?
	let success : Bool?
    let message : String?

	enum CodingKeys: String, CodingKey {
		case data = "data"
		case noOfNotification = "no_of_notification"
		case statusCode = "statusCode"
		case success = "success"
        case message = "message"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		data = try values.decodeIfPresent([NotificationData].self, forKey: .data) ?? []
		noOfNotification = try values.decodeIfPresent(Int.self, forKey: .noOfNotification) ?? Int()
		statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode) ?? Int()
		success = try values.decodeIfPresent(Bool.self, forKey: .success) ?? false
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
	}


}
