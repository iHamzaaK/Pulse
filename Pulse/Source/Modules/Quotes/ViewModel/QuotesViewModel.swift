//
//  QoutesViewModel.swift
//  Pulse
//
//  Created by Hamza Khan on 14/11/2020.
//

import Foundation
class QuotesViewModel
{
    let headerTitle = ""
    private let navBarType : navigationBarTypes!
    let repository : QuotesRepository!
    var arrQuote : [ArticleListingQuoteOfTheDay] = []
    init(navigationType navBar : navigationBarTypes, repo : QuotesRepository) {
        self.navBarType = navBar
        self.repository = repo
    }
    func getNavigationBar()-> navigationBarTypes{
        return navBarType
    }
    func getQuotesCount()->Int{
        return arrQuote.count
    }
    func cellViewModelForRow(row: Int)->QuoteCellViewModel{
        let quote = arrQuote[row]
        let cellViewModel = QuoteCellViewModel(id: quote.id ?? -1, quoteTitle: quote.title ?? "", author: quote.author ?? "", timeStamp: quote.timeStamp ?? "")
        return cellViewModel
    }
    func getQuotes(completionHandler: @escaping ( _ success : Bool , _ serverMsg : String)->Void){
        self.repository.getQuotes { (success, serverMsg, quoteData) in
            if success{
                guard let data = quoteData else {
                    completionHandler(false , "Invalid response")
                    return
                }
                self.arrQuote = data
                completionHandler(success , serverMsg)
            }
        }
    }
}

struct QuoteCellViewModel {
    let id : Int
    let quoteTitle : String
    let author : String
    let timeStamp : String
    
    func getAuthor()->String{
        if author == ""{
            return ""
        }
        return "- \(author)"
    }
}

