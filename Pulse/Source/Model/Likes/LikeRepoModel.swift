//
//  LikeRepoModel.swift
//  Pulse
//
//  Created by FraunhoferWork on 12/12/2020.
//

import Foundation
struct LikesRepoModel : Codable {

    let success : Bool?
    let statusCode : Int?
    let message : String?
    let no_of_likes : Int?
    let is_liked : Bool?

    enum CodingKeys: String, CodingKey {
        case statusCode = "statusCode"
        case message = "message"
        case success = "success"
        case no_of_likes = "no_of_likes"
        case is_liked = "is_liked"
    
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode) ?? Int()
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? String()
        success = try values.decodeIfPresent(Bool.self, forKey: .success) ?? Bool()
        is_liked = try values.decodeIfPresent(Bool.self, forKey: .is_liked) ?? Bool()
        no_of_likes = try values.decodeIfPresent(Int.self, forKey: .no_of_likes) ?? Int()


    }


}

