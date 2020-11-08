//
//  ForgetPasswordBuildder.swift
//  Pulse
//
//  Created by Hamza Khan on 07/11/2020.
//

import UIKit
class ForgetPasswordBuilder{
    static func build()-> UIViewController{
        let sb = Utilities.getStoryboard(identifier: Storyboards.auth.rawValue)
        let vc = sb.instantiateViewController(identifier: ViewControllersIdentifier.forgetPassword.rawValue) as! ForgetPasswordViewController
        let navBarType = navigationBarTypes.backButtonWithRightOptionsButton
        let viewModel = ForgetPasswordViewModel(navigationType: navBarType)
        vc.viewModel = viewModel
        return vc
    }
}
