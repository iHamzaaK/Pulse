//
//  QuotesRepository.swift
//  Pulse
//
//  Created by FraunhoferWork on 12/12/2020.
//

import Foundation

protocol QuotesRepository {
    func getQuotes(completionHandler: @escaping ( _ success : Bool , _ serverMsg : String , [ArticleListingQuoteOfTheDay]?)->Void)
}
