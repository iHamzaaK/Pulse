//
//  LoginRepo.swift
//  Pulse
//
//  Created by Hamza Khan on 27/11/2020.
//

import Foundation

struct LoginRepo : Decodable {

    let code : String?
    var data : LoginData?
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
        message = try values.decodeIfPresent(String.self, forKey: .message)
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode)  ??  Int()
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        do{
            data = try values.decodeIfPresent(LoginData.self, forKey: .data)
        }
        catch{
//            let tempData = try values.decodeIfPresent(LoginData.self, forKey: .data)

            data = nil
        }

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
    let subscription : [String]?


        enum CodingKeys: String, CodingKey {
            case displayName = "displayName"
            case email = "email"
            case firstName = "firstName"
            case id = "id"
            case lastName = "lastName"
            case nicename = "nicename"
            case token = "token"
            case subscription = "subscription"
        }
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            displayName = try values.decodeIfPresent(String.self, forKey: .displayName) ?? String()
            email = try values.decodeIfPresent(String.self, forKey: .email) ?? String()
            firstName = try values.decodeIfPresent(String.self, forKey: .firstName) ?? String()
            id = try values.decodeIfPresent(Int.self, forKey: .id) ?? Int()
            lastName = try values.decodeIfPresent(String.self, forKey: .lastName) ?? String()
            nicename = try values.decodeIfPresent(String.self, forKey: .nicename) ?? String()
            token = try values.decodeIfPresent(String.self, forKey: .token) ?? String()
            subscription = try values.decodeIfPresent([String].self, forKey: .subscription) ?? []

        }


    
}
