//
//  CommentsBuilder.swift
//  Pulse
//
//  Created by Hamza Khan on 14/11/2020.
//

import Foundation
class CommmentsViewBuilder
{
    static func build()-> UIViewController{
        let sb = Utilities.getStoryboard(identifier: Storyboards.comments.rawValue)
        let vc = sb.instantiateViewController(identifier: ViewControllersIdentifier.comments.rawValue) as! CommentsViewController
        let navBarType = navigationBarTypes.clearNavBar

        let viewModel = CommentsViewModel(navigationType: navBarType)
        vc.viewModel = viewModel
        return vc
    }
}
