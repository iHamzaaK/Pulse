//
//  ArticleDetailRepository.swift
//  Pulse
//
//  Created by FraunhoferWork on 10/12/2020.
//
import Foundation
protocol ArticleDetailRepository{
    func getArticleDetail(articleID: String, completionHandler: @escaping (Bool, String, _ articleDetail :  [PostDetailData]?, _ articleComments : [PostDetailComment]?) -> Void)
}
