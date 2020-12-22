//
//  ArticleListingBuilder.swift
//  Pulse
//
//  Created by Hamza Khan on 05/12/2020.
//

import Foundation
class ArticleListingBuilder
{
    static func build(title : String, type : articleListingType, categoryId : Int?, navBarType: navigationBarTypes)-> UIViewController{
        let sb = Utilities.getStoryboard(identifier: Storyboards.articleListing.rawValue)
        let vc = sb.instantiateViewController(identifier: ViewControllersIdentifier.articleListing.rawValue) as! ArticleListingViewController
        let navBarType = navBarType
        let repo = ArticleListingRepositoryImplementation()
        let commentRepo = CommentsRepositoryImplementation()
        let bookmarkRepo = BookmarksRepositoryImplementation()
        let likeRepo = LikesRepositoryImplementation()
        let videoRepo = VideosRepositoryImplementation()
        let viewModel = ArticleListingViewModel(navigationType: navBarType, type: type, repo : repo, categoryId: categoryId, title : title, bookmarkRepo: bookmarkRepo, likeRepo: likeRepo,videoRepository: videoRepo, commentRepository : commentRepo)
        vc.viewModel = viewModel
        return vc
    }
}
