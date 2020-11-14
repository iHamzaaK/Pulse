//
//  FullArticleBuilder.swift
//  Pulse
//
//  Created by Hamza Khan on 10/11/2020.
//

import UIKit
class FullArticleBuilder
{
    static func build()-> UIViewController{
        let sb = Utilities.getStoryboard(identifier: Storyboards.fullArticle.rawValue)
        let vc = sb.instantiateViewController(identifier: ViewControllersIdentifier.fullArticle.rawValue) as! FullArticleViewController
        let navBarType = navigationBarTypes.backButtonWithRightOptionsButton

        let viewModel = FullArticleViewModel(navigationType: navBarType)
        vc.viewModel = viewModel
        return vc
    }
}
