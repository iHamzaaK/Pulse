//
//  VideosBuilder.swift
//  Pulse
//
//  Created by Hamza Khan on 14/11/2020.
//

import UIKit
class VideosBuilder
{
    static func build()-> UIViewController{
        let sb = Utilities.getStoryboard(identifier: Storyboards.videos.rawValue)
        let vc = sb.instantiateViewController(identifier: ViewControllersIdentifier.videos.rawValue) as! VideosViewController
        let navBarType = navigationBarTypes.backButtonWithRightMenuButton
        let repo = VideosRepositoryImplementation()
        let viewModel = VideosViewModel(navigationType: navBarType, repo : repo, type: .videos)
        vc.viewModel = viewModel
        return vc
    }
}
