//
//  ConfirmPasswordBuilder.swift
//  Pulse
//
//  Created by Hamza Khan on 08/11/2020.
//

import UIKit
class ConfirmPasswordBuilder{
   
    static func build(email : String)-> UIViewController{
        let sb = Utilities.getStoryboard(identifier: Storyboards.auth.rawValue)
        let vc = sb.instantiateViewController(identifier: ViewControllersIdentifier.confirmPassword.rawValue) as! ConfirmPasswordViewController
        let navBarType = navigationBarTypes.backButtonWithRightMenuButton
        let repository = ConfirmPasswordRepositoryImplementation()
        let confirmPasswordViewModel = ConfirmPasswordViewModel(navigationType: navBarType, injectRepo: repository, email: email)
        vc.viewModel = confirmPasswordViewModel
        
        return vc
    }
}
