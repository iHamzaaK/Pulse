//
//  NotificationListingBuilder.swift
//  Pulse
//
//  Created by Hamza Khan on 15/12/2020.
//

import Foundation

final class NotificationListingBuilder {
  static func build()-> UIViewController{
    let sb = Utilities.getStoryboard(identifier: Storyboards.notificationListing.rawValue)
    let vc = sb.instantiateViewController(identifier: ViewControllersIdentifier.notificationListing.rawValue) as! NotificationListingViewController
    let navBarType = navigationBarTypes.backButtonWithTitle
    let repo = NotificationListingRepositoryImplementation()
    let viewModel = NotificationListingViewModel(navigationType: navBarType, repo : repo)
    vc.viewModel = viewModel
    return vc
  }
}
