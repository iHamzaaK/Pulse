//
//  ArticleDetailRepository.swift
//  Pulse
//
//  Created by Hamza Khan on 10/12/2020.
//
protocol ArticleDetailRepository{
  func getArticleDetail(articleID: String, completionHandler: @escaping (Bool, String, _ articleDetail :  [PostDetailData]?, _ articleComments : [PostDetailComment]?) -> Void)
}
