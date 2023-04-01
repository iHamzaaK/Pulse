//
//  SearchBuilder.swift
//  Pulse
//
//  Created by Hamza Khan on 27/11/2020.
//

import Foundation
import UIKit

final class SearchBuilder {
  static func build()-> UIViewController{
    let sb = Utilities.getStoryboard(identifier: Storyboards.search.rawValue)
    let vc = sb.instantiateViewController(identifier: ViewControllersIdentifier.search.rawValue) as! SearchViewController
    let navBarType = navigationBarTypes.searchNavBar
    let repo = SearchRepositoryImplementation()
    let viewModel = SearchViewModel(navigationType: navBarType, repo : repo)
    vc.viewModel = viewModel
    return vc
  }
}
