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
    let likesRepository : LikesRepository!
    let commentRepository : CommentsRepository!
    init(navigationType navBar : navigationBarTypes, repo : ArticleDetailRepository, articleID : String, bookmarkRepo: BookmarksRepository, likesRepo : LikesRepository, commentRepo : CommentsRepository) {
        self.navBarType = navBar
        self.repository = repo
        self.articleID  = articleID
        self.bookmarkRepository = bookmarkRepo
        self.likesRepository = likesRepo
        self.commentRepository = commentRepo
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
    func getVideoURl()->String{
        return articleData.videoUrl ?? ""
    }
    func getAllLikes(completionHandler: @escaping ( _ success :Bool , _ serverMsg : String, _ vc: UIViewController? )->Void){
        let articleID = articleData.id ?? ""
        self.likesRepository.getAllLikes(articleID: articleID) { (success, serverMsg,  _ userLikedArr : [AllLikesData]?) in
            if success{
                guard let userLikedArr = userLikedArr else {
                    completionHandler(success, serverMsg , nil)

                    return }
                let vc = LikesViewBuilder.build(userLikeArr: userLikedArr)
                completionHandler(success, serverMsg , vc)
            }
            else{
                completionHandler(success, serverMsg , nil)
            }
        }
    }
    func getLiked( completionHandler: @escaping (  _ success : Bool , _ serverMsg : String, _ isLiked : Bool?)->Void){
        let articleID = articleData.id ?? ""

        self.likesRepository.getLiked(articleID: articleID) { (success, serverMsg, _ isLiked : Bool?) in
            if success{
                guard let isLiked = isLiked else {
                    completionHandler(false, "Invalid Response", nil)
                    return
                }
                self.articleData.isLiked = isLiked
//                article.isLiked = isLiked
                if isLiked{
                    self.articleData.likeCount = self.articleData.likeCount! + 1
                }
                else{
                    self.articleData.likeCount = self.articleData.likeCount! - 1
                }
//                self.artiicleList[row] = article
                
                completionHandler(success, serverMsg, isLiked)
            }
            else{
                completionHandler(success,serverMsg,nil)
            }

        }
    }
    func postComment(comment : String, completionHandler: @escaping (_ success : Bool , _ serverMsg : String)->Void){
        self.commentRepository.postComment(id: articleID, comment: comment) { (success, serverMsg, commentData) in
            if success{
                guard let commentData = commentData else { completionHandler(false , "Invalid Response")
                    return }
                self.articleComments.append(commentData)
            }
            completionHandler(success , serverMsg)

        }
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
        let fontSize = DesignUtility.convertToRatio(15.0, sizedForIPad:  DesignUtility.isIPad, sizedForNavi: false)
        let text =  Utilities.getAttributedStringForHTMLWithFont(articleData.descriptionField ?? "", textSize: Int(fontSize), fontName: "Montserrat-Regular")
    
        return text
    }
    func getTitle()->String{
        return articleData.title ?? ""
    }
    func getWeblink()->String{
        return articleData.permalink ?? ""
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
    func isLiked()->Bool{
        return articleData.isLiked ?? false
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
    func didTapOnSeeAllComments(row : Int , completionHandler: (_ vc : UIViewController)->Void){
        let comment = articleComments[row]
        let vc = CommmentsViewBuilder.build(articleID: String(comment.id ?? -1))
        completionHandler(vc)
    }
    func addRemoveBookmark(completionHandler: @escaping ( _ isBookmarked : Bool , _ success : Bool , _ serverMsg : String)->Void){
       
        let articleID = articleData.id ?? ""
        self.bookmarkRepository.adddRemoveBookmark(id: articleID) { (success, message) in
            if success {
                if message == "Bookmark has successfully saved."{
                    
                    self.articleData.isBookmarked = true
                    completionHandler(true,success, message)
                }
                else{
                    self.articleData.isBookmarked = false
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
