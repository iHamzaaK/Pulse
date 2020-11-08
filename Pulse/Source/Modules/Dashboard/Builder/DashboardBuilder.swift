//
//  DashboardBuilder.swift
//  Pulse
//
//  Created by Hamza Khan on 08/11/2020.
//

import UIKit

class DashboardBuilder{
     static func build()-> UIViewController{
           let sb = Utilities.getStoryboard(identifier: Storyboards.dashboard.rawValue)
           let vc = sb.instantiateViewController(identifier: ViewControllersIdentifier.dashboard.rawValue) as! DashboardViewController
           let navBarType = navigationBarTypes.clearNavBar
           let viewModel = DashboardViewModel(navigationType: navBarType)
           vc.viewModel = viewModel
           
           return vc
       }
}

