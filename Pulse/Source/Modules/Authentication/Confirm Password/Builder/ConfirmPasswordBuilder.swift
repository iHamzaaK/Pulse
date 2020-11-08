//
//  ConfirmPasswordBuilder.swift
//  Pulse
//
//  Created by Hamza Khan on 08/11/2020.
//

import UIKit
class ConfirmPasswordBuilder{
    static func build()-> UIViewController{
        let sb = Utilities.getStoryboard(identifier: Storyboards.auth.rawValue)
        let vc = sb.instantiateViewController(identifier: ViewControllersIdentifier.confirmPassword.rawValue) as! ConfirmPasswordViewController
        let navBarType = navigationBarTypes.backButtonWithRightOptionsButton
        let viewModel = ConfirmPasswordViewModel(navigationType: navBarType)
        vc.viewModel = viewModel
        return vc
    }
}
