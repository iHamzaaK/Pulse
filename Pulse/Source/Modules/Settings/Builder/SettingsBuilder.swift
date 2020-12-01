//
//  SettingsBuilder.swift
//  Pulse
//
//  Created by Hamza Khan on 20/11/2020.
//

import Foundation

import UIKit
class SettingsBuilder
{
    static func build()-> UIViewController{
        let sb = Utilities.getStoryboard(identifier: Storyboards.settings.rawValue)
        let vc = sb.instantiateViewController(identifier: ViewControllersIdentifier.settings.rawValue) as! SettingsViewController
        let navBarType = navigationBarTypes.backButtonWithRightMenuButton

        let viewModel = SettingsViewModel(navigationType: navBarType)
        vc.viewModel = viewModel
        return vc
    }
}


