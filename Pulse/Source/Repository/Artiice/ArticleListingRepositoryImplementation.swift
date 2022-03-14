//
//  ArticleListingRepositoryImplementation.swift
//  Pulse
//
//  Created by Hamza Khan on 05/12/2020.
//

import Foundation
class ArticleListingRepositoryImplementation : ArticleListingRepository{

    private let url = "wp/v2/sahifa/category/posts?"
    private var isSuccess = false
    private var serverMsg = ""
    func getListing(type: articleListingType, keyword: String = "", date: Int = 0, paged: Int, categoryId: Int?, completionHandler: @escaping (Bool, String, [ArticleListingData]?, [ArticleListingQuoteOfTheDay]?, _  maxPages: Int) -> Void) {
        
        var endpoint = ""
        switch type {
        case .topStories:
            endpoint = "s=\(keyword)&date=\(date)&paged=\(paged)&posts_per_page=20&type=\(type.rawValue)"
        case .myNews:
            endpoint = "s=\(keyword)&date=\(date)&paged=\(paged)&posts_per_page=20&type=\(type.rawValue)"
        case .categories:
            endpoint = "s=\(keyword)&date=\(date)&category_id=\(categoryId!)&paged=\(paged)&posts_per_page=20&type=\(type.rawValue)"
        case .interest:
            endpoint = "s=\(keyword)&date=\(date)&paged=\(paged)&posts_per_page=20&type=\(2)"
        case .bookmarks:
            endpoint = "s=\(keyword)&date=\(date)&paged=\(paged)&posts_per_page=20&type=\(type.rawValue)"
        case .videos:
            break
        }
        
        
        DispatchQueue.main.async{
            ActivityIndicator.shared.showSpinner(nil,title: nil)
        }
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer " + ArchiveUtil.getUserToken(),
            "Content-Type": "application/x-www-form-urlencoded"

        ]
      endpoint = endpoint.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        BaseRepository.instance.requestService(url: url + endpoint, method: .get, params: nil, header: headers) { (success, serverMsg, data) in
            print(data)
            self.isSuccess = success
            self.serverMsg = serverMsg
            if self.isSuccess{
                guard let data = data else { return }
                let decoder = JSONDecoder()
                let model = try? decoder.decode(ArticleListingRepoModel.self, from: data.rawData())
                guard let success = model?.success else { return }
                let articleListing = model?.data
//                let quote = model?.quoteOfTheDay
                let maxPages = model?.maxNumPages
                self.isSuccess = success
                
                guard let statusMsg = model?.message else { return }
                self.serverMsg = statusMsg
                completionHandler(self.isSuccess,serverMsg, articleListing, nil , maxPages!)
                
            }
            else{
                completionHandler(self.isSuccess, self.serverMsg, nil , nil, 0)
            }
            
        }
    }
}
