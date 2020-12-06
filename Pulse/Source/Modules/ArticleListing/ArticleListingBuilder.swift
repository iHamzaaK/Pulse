//
//  ArticleListingBuilder.swift
//  Pulse
//
//  Created by Hamza Khan on 05/12/2020.
//

import Foundation
class ArticleListingBuilder
{
    static func build(title : String, type : articleListingType, categoryId : Int?)-> UIViewController{
        let sb = Utilities.getStoryboard(identifier: Storyboards.articleListing.rawValue)
        let vc = sb.instantiateViewController(identifier: ViewControllersIdentifier.articleListing.rawValue) as! ArticleListingViewController
        let navBarType = navigationBarTypes.backButtonWithTitle
        let repo = ArticleListingRepositoryImplementation()
        let viewModel = ArticleListingViewModel(navigationType: navBarType, type: type, repo : repo, categoryId: categoryId, title : title )
        vc.viewModel = viewModel
        return vc
    }
}
