//
//  FullArticleViewModel.swift
//  Pulse
//
//  Created by Hamza Khan on 10/11/2020.
//

import Foundation
import UIKit

class FullArticleViewModel
{
    let headerTitle = ""
    private let navBarType : navigationBarTypes!
    let repository : ArticleDetailRepository!
    let articleID : String!
    var articleData : PostDetailData!
    var articleComments = [PostDetailComment]()
    let bookmarkRepository : BookmarksRepository!

    init(navigationType navBar : navigationBarTypes, repo : ArticleDetailRepository, articleID : String, bookmarkRepo: BookmarksRepository) {
        self.navBarType = navBar
        self.repository = repo
        self.articleID  = articleID
        self.bookmarkRepository = bookmarkRepo
    }
    func getNavigationBar()-> navigationBarTypes{
        return navBarType
    }
    func getImageURL()->URL?{
        guard let url = URL(string: articleData.thumbnail ?? "") else { return nil}
        return url
    }
    func isVideo()->Bool{
        return articleData.isVideo ?? false
    }
    func getTotalLikeCount()->String{
        var strUserLiked = ""
        var othersLiked = ""
        let isLiked = (articleData.isLiked ?? false)
        let likeCount = articleData.likeCount ?? 0
        if isLiked{
            strUserLiked = "You"
        }
        if likeCount > 0{
            othersLiked = "\(likeCount) others liked this"
        }
        
        if isLiked && likeCount > 0{
            return strUserLiked + " and " + othersLiked
        }
        else if isLiked && likeCount < 1{
            return "\(strUserLiked) liked this"
        }
        else if !isLiked &&  likeCount > 0{
            return othersLiked
        }
        else{
            return ""
        }
    }
    func getDescription()->NSAttributedString?{
        let fontSize = DesignUtility.convertToRatio(15.0, sizedForIPad: false, sizedForNavi: false)
        let text =  Utilities.getAttributedStringForHTMLWithFont(articleData.descriptionField ?? "", textSize: Int(fontSize), fontName: "Montserrat-Regular")
    
        return text
    }
    func getTitle()->String{
        return articleData.title ?? ""
    }
    func getType()->String{
        return articleData.tag ?? ""
    }
    func getTimeStamp()->String{
        return articleData.daysAgo ?? ""
    }
    func getCommentCounts()->Int{
        return articleComments.count
    }
    func isBookmarked()->Bool{
        return articleData.isBookmarked ?? false
    }
    func cellViewModelForComment(row: Int)->CommentCellViewModel{
        let comment = articleComments[row]
        let cellViewModel = CommentCellViewModel(id: comment.id ?? -1 , comment: comment.commentContent ?? "", author: comment.commentAuthor ?? "", timestamp: comment.daysAgo ?? "", avatar: comment.avatar ?? "")
        return cellViewModel
    }
    func getArticleData(completionHandler: @escaping ( _ success : Bool , _ message : String)->Void){
        self.repository.getArticleDetail(articleID: articleID) { (success, serverMsg, data, commments)  in
            if success{
                if let articleData = data?.first{
                    self.articleData = articleData
                }
                if let articleComments = commments{
                    self.articleComments = commments ?? []
                }
            
            }
            completionHandler(success , serverMsg)
        }
    }
    func addRemoveBookmark(completionHandler: @escaping ( _ isBookmarked : Bool , _ success : Bool , _ serverMsg : String)->Void){
       
        let articleID = articleData.id ?? ""
        self.bookmarkRepository.adddRemoveBookmark(id: articleID) { (success, message) in
            if success {
                if message == "Bookmark has successfully saved."{
                    
                    completionHandler(true,success, message)
                }
                else{
                   

                    completionHandler(false,success, message)
                }
            }
            else{
                completionHandler(false,success, message)

            }
        }
    }
}
struct CommentCellViewModel{
    let id : Int
    let comment : String
    let author: String
    let timestamp: String
    let avatar : String
    
    func getImageURL()->URL?{
        return URL(string: avatar)
    }
}
