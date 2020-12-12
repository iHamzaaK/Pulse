//
//  FullArticleBuilder.swift
//  Pulse
//
//  Created by Hamza Khan on 10/11/2020.
//

import UIKit
class FullArticleBuilder
{
    static func build(articleID: String)-> UIViewController{
        let sb = Utilities.getStoryboard(identifier: Storyboards.fullArticle.rawValue)
        let vc = sb.instantiateViewController(identifier: ViewControllersIdentifier.fullArticle.rawValue) as! FullArticleViewController
        let navBarType = navigationBarTypes.backButtonWithRightMenuButton
        let repo  = ArticleDetailRepositoryImplementation()
        let bookmarkRepo = BookmarksRepositoryImplementation()
        let likesRepo = LikesRepositoryImplementation()
        let viewModel = FullArticleViewModel(navigationType: navBarType, repo : repo, articleID: articleID, bookmarkRepo: bookmarkRepo, likesRepo: likesRepo)
        vc.viewModel = viewModel
        return vc
    }
}
