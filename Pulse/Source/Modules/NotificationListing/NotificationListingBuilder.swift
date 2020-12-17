//
//  NotificationListingBuilder.swift
//  Pulse
//
//  Created by FraunhoferWork on 15/12/2020.
//

import Foundation
class NotificationListingBuilder
{
    static func build()-> UIViewController{
        let sb = Utilities.getStoryboard(identifier: Storyboards.notificationListing.rawValue)
        let vc = sb.instantiateViewController(identifier: ViewControllersIdentifier.notificationListing.rawValue) as! NotificationListingViewController
        let navBarType = navigationBarTypes.clearNavBar
        let repo = NotificationListingRepositoryImplementation()
        let viewModel = NotificationListingViewModel(navigationType: navBarType, repo : repo)
        vc.viewModel = viewModel
        return vc
    }
}
