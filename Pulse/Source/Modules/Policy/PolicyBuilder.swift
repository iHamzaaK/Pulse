//
//  PolicyBuilder.swift
//  Pulse
//
//  Created by FraunhoferWork on 17/12/2020.
//

import Foundation
class PolicyBuilder
{
    static func build(title: String)-> UIViewController{
        let sb = Utilities.getStoryboard(identifier: Storyboards.policy.rawValue)
        let vc = sb.instantiateViewController(identifier: ViewControllersIdentifier.policy.rawValue) as! PolicyViewController
        let navBarType = navigationBarTypes.backButtonWithRightMenuButton
        let repo = PolicyRepositoryImplementation()
        let viewModel = PolicyViewModel(navigationType: navBarType, repo : repo, title : title)
        vc.viewModel = viewModel
        return vc
    }
}
