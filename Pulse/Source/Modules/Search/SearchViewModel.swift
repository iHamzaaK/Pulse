//
//  SearchViewModel.swift
//  Pulse
//
//  Created by Hamza Khan on 27/11/2020.
//

import Foundation
class SearchViewModel
{
    let headerTitle = ""
    private let navBarType : navigationBarTypes!
    let repository : SearchRepository!
    var searchData : [SearchData] = []
    let limitPost = 100
    init(navigationType navBar : navigationBarTypes, repo : SearchRepository) {
        self.navBarType = navBar
        self.repository = repo
    }
    func getNavigationBar()-> navigationBarTypes{
        return navBarType
    }
    func getSearchCount()->Int{
        return searchData.count
    }
    func cellViewModelForRow(row: Int)->SearchCellViewModel{
        let article = searchData[row]
        let cellViewModel = SearchCellViewModel(articleID: article.id ?? "-1", articleTitle: article.title ?? "")
        return cellViewModel
    }
  func getSearchData(searchText : String, dateTime: Int = 0, completionHandler: @escaping ( _ success : Bool , _ serverMsg : String)->Void){
    self.repository.search(searchText: searchText, dateTime: dateTime, limit: limitPost) { (success, serverMsg, data) in
            if success{
                guard let data = data else { return }
                self.searchData = data
            }
            completionHandler(success,serverMsg)
        }
    }
    func didTapOnCell(row: Int, completionHandler: ( _ vc : UIViewController)->Void){
        let article = searchData[row]
        let articleID = article.id ?? ""
        let vc = FullArticleBuilder.build(articleID: articleID, headerType: .backButtonWithRightMenuButton)
        completionHandler(vc)
    }
}

struct SearchCellViewModel {
    let articleID : String
    let articleTitle : String
}
