//
//  QoutesBuilder.swift
//  Pulse
//
//  Created by Hamza Khan on 14/11/2020.
//

import UIKit
class QuotesBuilder
{
    static func build()-> UIViewController{
        let sb = Utilities.getStoryboard(identifier: Storyboards.quotes.rawValue)
        let vc = sb.instantiateViewController(identifier: ViewControllersIdentifier.quotes.rawValue) as! QuotesViewController
        let navBarType = navigationBarTypes.backButtonWithRightMenuButton
        let repo  = QuotesRepositoryImplementation()
        let viewModel = QuotesViewModel(navigationType: navBarType, repo : repo)
        vc.viewModel = viewModel
        return vc
    }
}
