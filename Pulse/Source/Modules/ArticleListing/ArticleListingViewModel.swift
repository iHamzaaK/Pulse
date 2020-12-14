//
//  ArticleListing.swift
//  Pulse
//
//  Created by Hamza Khan on 05/12/2020.
//

import Foundation
class ArticleListingViewModel
{
    let headerTitle: String!
    private let navBarType : navigationBarTypes!
    let type : articleListingType!
    let repository : ArticleListingRepository!
    let bookmarkRepository : BookmarksRepository!
    let likeRepository : LikesRepository!

    var categoryId = -1
    var artiicleList : [ArticleListingData] = []
    var quote : [ArticleListingQuoteOfTheDay] = []
    var maximumPages = 1
    init(navigationType navBar : navigationBarTypes, type : articleListingType, repo : ArticleListingRepository, categoryId : Int?, title : String, bookmarkRepo : BookmarksRepository, likeRepo : LikesRepository) {
        self.navBarType = navBar
        self.type = type
        self.repository = repo
        if categoryId != nil{
            self.categoryId = categoryId ?? -1
        }
        self.headerTitle = title
        self.bookmarkRepository = bookmarkRepo
        self.likeRepository = likeRepo
    }
    func getNavigationBar()-> navigationBarTypes{
        return navBarType
    }
    func getHeaderTitle()->String{
        self.headerTitle
    }
    func getQuote()->ArticleListingQuoteOfTheDay?{
        return self.quote.first
    }
    func getArticleCount()->Int{
        return self.artiicleList.count
    }
    func showTitle()->Bool{
        if type != articleListingType.bookmarks && type != articleListingType.interest{
            return true
        }
        return false
    }
    func showQuoteView()->Bool{
        if type == articleListingType.topStories && self.getQuote()?.title != ""{
            return true
        }
        return false
    }
    func getListing(paged: Int, completionHandler: @escaping (Bool, String)->Void){
        var id : Int? = nil
        if categoryId != -1{
            id = categoryId
        }
        if paged == 1 || paged < maximumPages{
        self.repository.getListing(type: self.type, paged: paged, categoryId: categoryId) { (success, serverMsg, data, quote , maxPage)  in
            self.maximumPages = maxPage
            self.artiicleList.append(contentsOf: data ?? [])
            self.quote = quote ?? []
            completionHandler(success, serverMsg)
        }
        }
    }
    func cellViewModelForRow(row:Int)->ArticleListingCellViewModel{
        let article = artiicleList[row]
        let cellViewModel = ArticleListingCellViewModel(articleID: article.id ?? -1, title: article.title ?? "", permalink: article.permalink ?? "", thumbnail: article.thumbnail  ?? "", description: article.descriptionField  ?? "", isVideo: article.isVideo ?? false, videoURL: article.videoUrl ?? "", type : self.type,shortDescription: article.shortDescription , date: article.date ,tag: article.tag,isBookmarked: article.isBookmarked,isLiked: article.isLiked , likeCount: article.likeCount)
        return cellViewModel
    }
    func didTapOnCell(row: Int, completionHandler:( _ vc : UIViewController)->Void){
        let article = artiicleList[row]
        let articleID = String(article.id ?? -1)
        let vc = FullArticleBuilder.build(articleID: articleID)
        completionHandler(vc)
    }
    func getLiked(row : Int , completionHandler: @escaping (  _ success : Bool , _ serverMsg : String, _ isLiked : Bool?)->Void){
        var article = artiicleList[row]
        let articleID = String(article.id ?? -1)

        self.likeRepository.getLiked(articleID: articleID) { (success, serverMsg, _ isLiked : Bool?) in
            if success{
                guard let isLiked = isLiked else {
                    completionHandler(false, "Invalid Response", nil)
                    return
                }
                article.isLiked = isLiked
                if isLiked{
                    article.likeCount = article.likeCount + 1
                }
                else{
                    article.likeCount = article.likeCount - 1
                }
                self.artiicleList[row] = article
                
                completionHandler(success, serverMsg, isLiked)
            }
            else{
                completionHandler(success,serverMsg,nil)
            }

        }
    }
    func addRemoveBookmark(row: Int ,completionHandler: @escaping ( _ isBookmarked : Bool , _ success : Bool , _ serverMsg : String)->Void){
        let article = artiicleList[row]
        let articleID = String(article.id ?? -1)
        self.bookmarkRepository.adddRemoveBookmark(id: articleID) { (success, message) in
            if success {
                if message == "Bookmark has successfully saved."{
                    self.artiicleList[row].isBookmarked = true
                    completionHandler(true,success, message)
                }
                else{
                    self.artiicleList[row].isBookmarked = false

                    completionHandler(false,success, message)
                }
            }
            else{
                completionHandler(false,success, message)

            }
        }
    }
}


struct ArticleListingCellViewModel{
    let articleID : Int
    let title : String
    let permalink : String
    let thumbnail : String
    let description : String
    let isVideo : Bool
    let videoURL : String
    let type : articleListingType
    let shortDescription: String
    let date : String
    let tag : String
    var isBookmarked : Bool
    var isLiked : Bool
    let likeCount : Int
    
    func getShortDescription()->String{
        return shortDescription
    }
    
    
    
    func getVideoURL()-> URL?{
        guard let url = URL(string: videoURL) else { return nil}
        return url
    }
    func getBgImageURLForCell()-> URL?{
        return URL(string: thumbnail)

    }
    func getDescription()-> NSAttributedString?{
        var fontSize = 15
        if DesignUtility.isIPad{
            fontSize = 22
        }
        fontSize = Int(DesignUtility.convertToRatio(CGFloat(fontSize), sizedForIPad: DesignUtility.isIPad, sizedForNavi: false))
        let attirbutedString = Utilities.getAttributedStringForHTMLWithFont(description, textSize: fontSize, fontName: "Helvetica")
        return attirbutedString
    }
}
