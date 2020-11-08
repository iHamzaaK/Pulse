//
//  SplashBuildder.swift
//  Pulse
//
//  Created by Hamza Khan on 07/11/2020.
//
import UIKit
class SplashBuilder
{
    static func build()-> UIViewController{
        let sb = Utilities.getStoryboard(identifier: Storyboards.splash.rawValue)
        let vc = sb.instantiateViewController(identifier: ViewControllersIdentifier.splash.rawValue) as! SplashViewController
        let navBarType = navigationBarTypes.clearNavBar

        let viewModel = SplashViewModel(navigationType: navBarType)
        vc.viewModel = viewModel
        return vc
    }
}
