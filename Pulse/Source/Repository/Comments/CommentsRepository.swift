//
//  CommentsRepository.swift
//  Pulse
//
//  Created by Hamza Khan on 02/12/2020.
//

import Foundation
protocol CommentsRepository{
    func getAllComments(articleID : String, completionHandler: @escaping (Bool, String, _ comments: [PostDetailComment]?) -> Void)
}
