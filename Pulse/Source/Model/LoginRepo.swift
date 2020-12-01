//
//  LoginRepo.swift
//  Pulse
//
//  Created by Hamza Khan on 27/11/2020.
//

import Foundation

struct LoginRepo : Decodable {

    let code : String?
    let data : LoginData?
    let message : String?
    let statusCode : Int?
    let success : Bool?


    enum CodingKeys: String, CodingKey {
        case code = "code"
        case data = "data"
        case message = "message"
        case statusCode = "statusCode"
        case success = "success"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
//        data = try LoginData(from: decoder)
        data = try values.decodeIfPresent(LoginData.self, forKey: .data)  //?? LoginData()

        message = try values.decodeIfPresent(String.self, forKey: .message)
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
    }


}

// MARK: - DataClass
struct LoginData: Decodable {
   

        let displayName : String?
        let email : String?
        let firstName : String?
        let id : Int?
        let lastName : String?
        let nicename : String?
        let token : String?


        enum CodingKeys: String, CodingKey {
            case displayName = "displayName"
            case email = "email"
            case firstName = "firstName"
            case id = "id"
            case lastName = "lastName"
            case nicename = "nicename"
            case token = "token"
        }
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            displayName = try values.decodeIfPresent(String.self, forKey: .displayName)
            email = try values.decodeIfPresent(String.self, forKey: .email)
            firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
            id = try values.decodeIfPresent(Int.self, forKey: .id)
            lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
            nicename = try values.decodeIfPresent(String.self, forKey: .nicename)
            token = try values.decodeIfPresent(String.self, forKey: .token)
        }


    
}
