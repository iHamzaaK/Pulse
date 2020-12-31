//
//  CommentsViewModel.swift
//  Pulse
//
//  Created by Hamza Khan on 14/11/2020.
//

import Foundation

class CommentsViewModel {
    
    let headerTitle = ""
    private let navBarType : navigationBarTypes!
    let repo : CommentsRepository!
    let articleID : String!
    var arrComments : [PostDetailComment] = []
    let articleTitle : String!
    init(navigationType navBar : navigationBarTypes, _ repo : CommentsRepository, articleID : String, articleTitle : String) {
        self.navBarType = navBar
        self.repo = repo
        self.articleID = articleID
        self.articleTitle = articleTitle
    }
    func getNavigationBar()-> navigationBarTypes{
        return navBarType
    }
    func getCommentsCount()->Int{
        return arrComments.count
    }
    func getArticleTitle()->String{
        return articleTitle
    }
    func cellViewModelForRow(row: Int)->CommentCellViewModel{
        let comment = arrComments[row]
        let cellViewModel = CommentCellViewModel(id: comment.id ?? -1, comment: comment.commentContent ?? "", author: comment.commentAuthor ?? "", timestamp: comment.daysAgo ?? "", avatar: comment.avatar ?? "")
        return cellViewModel
    }
    func getComments(completionHandler: @escaping (_ success : Bool , _ serverMsg : String)->Void){
        self.repo.getAllComments(articleID: articleID) { (success, serverMsg, data) in
                guard let data = data else {
                    completionHandler(false, "Invalid Response")
                    return
                }
                self.arrComments = data
                completionHandler(success, serverMsg)
        }
    }
    
}
