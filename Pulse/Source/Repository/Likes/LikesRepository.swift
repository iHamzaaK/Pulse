//
//  LikesRepository.swift
//  Pulse
//
//  Created by Hamza Khan on 02/12/2020.
//

protocol LikesRepository{
  func getLiked(articleID: String, completionHandler: @escaping (Bool, String,  _ isLiked : Bool?) -> Void)
  func getAllLikes(articleID : String, completionHandler: @escaping(Bool, String, _ userLikedArr : [AllLikesData]?)->Void)
}
