//
//  PolicyBuilder.swift
//  Pulse
//
//  Created by Hamza Khan on 17/12/2020.
//

import Foundation

final class PolicyBuilder {
  static func build(title: String, endPoint: String)-> UIViewController{
    let sb = Utilities.getStoryboard(identifier: Storyboards.policy.rawValue)
    let vc = sb.instantiateViewController(identifier: ViewControllersIdentifier.policy.rawValue) as! PolicyViewController
    let navBarType = navigationBarTypes.backButtonWithRightMenuButton
    let repo = PolicyRepositoryImplementation()
    let viewModel = PolicyViewModel(navigationType: navBarType, repo : repo, title : title, endPoint: endPoint)
    vc.viewModel = viewModel
    return vc
  }
}
