//
//  SearchBuilder.swift
//  Pulse
//
//  Created by Hamza Khan on 27/11/2020.
//

import Foundation
import UIKit
class SearchBuilder
{
    static func build()-> UIViewController{
        let sb = Utilities.getStoryboard(identifier: Storyboards.search.rawValue)
        let vc = sb.instantiateViewController(identifier: ViewControllersIdentifier.search.rawValue) as! SearchViewController
        let navBarType = navigationBarTypes.searchNavBar

        let viewModel = SearchViewModel(navigationType: navBarType)
        vc.viewModel = viewModel
        return vc
    }
}
