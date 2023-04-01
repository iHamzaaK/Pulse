//
//  CommentsRepository.swift
//  Pulse
//
//  Created by Hamza Khan on 02/12/2020.
//

protocol CommentsRepository{
  func getAllComments(articleID : String, completionHandler: @escaping (Bool, String, _ comments: [PostDetailComment]?) -> Void)
  func postComment(id :String, comment : String, completionHandler: @escaping (Bool, String , _ comment: PostDetailComment?)->Void)
}
