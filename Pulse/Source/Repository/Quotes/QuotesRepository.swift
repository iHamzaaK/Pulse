//
//  QuotesRepository.swift
//  Pulse
//
//  Created by Hamza Khan on 12/12/2020.
//

protocol QuotesRepository {
  func getQuotes(completionHandler: @escaping ( _ success : Bool , _ serverMsg : String , [ArticleListingQuoteOfTheDay]?)->Void)
}
