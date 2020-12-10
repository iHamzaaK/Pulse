//
//  ArticleListingRepository.swift
//  Pulse
//
//  Created by Hamza Khan on 05/12/2020.
//

import Foundation
protocol ArticleListingRepository{
    func getListing(type: articleListingType, paged : Int,categoryId : Int?, completionHandler: @escaping (Bool, String, _ articleList :  [ArticleListingData]? , _ quote: [ArticleListingQuoteOfTheDay]?, _  maxPages: Int) -> Void)
}
