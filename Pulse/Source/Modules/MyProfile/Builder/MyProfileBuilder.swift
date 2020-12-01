//
//  MyProfileBuilder.swift
//  Pulse
//
//  Created by Hamza Khan on 19/11/2020.
//

import UIKit
class MyProfileBuilder
{
    static func build()-> UIViewController{
        let sb = Utilities.getStoryboard(identifier: Storyboards.myProfile.rawValue)
        let vc = sb.instantiateViewController(identifier: ViewControllersIdentifier.myProfile.rawValue) as! MyProfileViewController
        let navBarType = navigationBarTypes.backButtonWithRightMenuButton

        let viewModel = MyProfileViewModel(navigationType: navBarType)
        vc.viewModel = viewModel
        return vc
    }
}
