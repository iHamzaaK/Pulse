//
//  LoginBuilder.swift
//  Pulse
//
//  Created by Hamza Khan on 07/11/2020.
//

import UIKit

final class LoginBuilder{
  static func build()-> UIViewController{
    let sb = Utilities.getStoryboard(identifier: Storyboards.auth.rawValue)
    let vc = sb.instantiateViewController(identifier: ViewControllersIdentifier.login.rawValue) as! LoginViewController
    let navBarType = navigationBarTypes.clearNavBar
    let loginRepo = LoginRepositoryImplementation()
    let viewModel = LoginViewModel(navigationType: navBarType, repository: loginRepo)
    vc.viewModel = viewModel
    return vc
  }
}
