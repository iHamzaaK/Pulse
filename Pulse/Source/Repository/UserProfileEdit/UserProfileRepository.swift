//
//  UserProfileRepository.swift
//  Pulse
//
//  Created by Hamza Khan on 02/12/2020.
//

protocol UserProfileRepository{
  func changeUserProfile(params : [String: String]?, avatar : Data?, completionHandler: @escaping (Bool, String) -> Void)
}
