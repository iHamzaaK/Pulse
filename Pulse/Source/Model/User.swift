//
//  User.swift
//  Pulse
//
//  Created by Hamza Khan on 27/11/2020.
//

import Foundation

struct User: Codable{
  var id : Int
  var firstName : String
  var lastName : String
  var displayName : String
  var email : String
  var password : String
  var accessToken : String
  var subscription : [String]
  var avatar : String
  var notificationOn : Bool
  func getAvatarURL()-> URL?{
    guard let url = URL(string: avatar) else { return nil}
    return url
  }
}

