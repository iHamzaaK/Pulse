//
//  LikesBuilder.swift
//  Pulse
//
//  Created by Hamza Khan on 02/12/2020.
//

import Foundation
class LikesViewBuilder
{
    static func build(userLikeArr : [AllLikesData])-> UIViewController{
        let sb = Utilities.getStoryboard(identifier: Storyboards.likes.rawValue)
        let vc = sb.instantiateViewController(identifier: ViewControllersIdentifier.likes.rawValue) as! LikesViewController
        let navBarType = navigationBarTypes.clearNavBar

        let viewModel = LikesViewModel(navigationType: navBarType, userLikeArr: userLikeArr)
        vc.viewModel = viewModel
        return vc
    }
}
