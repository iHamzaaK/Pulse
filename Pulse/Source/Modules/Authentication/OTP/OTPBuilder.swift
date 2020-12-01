//
//  OTPBuilder.swift
//  Pulse
//
//  Created by Hamza Khan on 01/12/2020.
//

import Foundation
class OTPBuilder
{
    static func build(email : String)-> UIViewController{
        let sb = Utilities.getStoryboard(identifier: Storyboards.auth.rawValue)
        let vc = sb.instantiateViewController(identifier: ViewControllersIdentifier.otp.rawValue) as! OTPViewController
        let navBarType = navigationBarTypes.backButtonWithTitle
        let repo = OTPRepositoryImplementation()
        let forgetPassRepo = ForgetPasswordRepositoryImplementation()

        let viewModel = OTPViewModel(navigationType: navBarType, repo : repo,  email: email, forgetPassRepo: forgetPassRepo)
        vc.viewModel = viewModel
        return vc
    }
}
