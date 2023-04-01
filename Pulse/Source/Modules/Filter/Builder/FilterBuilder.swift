//
//  FilterBuilder.swift
//  Pulse
//
//  Created by Hamza Khan on 07.03.22.
//

import UIKit

final class FilterBuilder
{
  static func build(title : String, navBarType: navigationBarTypes)-> UIViewController {
    let sb = Utilities.getStoryboard(identifier: Storyboards.filter.rawValue)
    let vc = sb.instantiateViewController(identifier: ViewControllersIdentifier.filter.rawValue) as! FilterViewController
    let navBarType = navBarType
    let viewModel = FilterViewModelImplementation(navBar: navBarType)
    vc.viewModel = viewModel
    return vc
  }
}
