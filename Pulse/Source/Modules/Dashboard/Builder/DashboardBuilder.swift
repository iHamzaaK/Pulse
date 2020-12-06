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
          let navBarType = navigationBarTypes.leftRightButtonsWithLogo
          let viewModel = DashboardViewModel(navigationType: navBarType)
          vc.viewModel = viewModel
          
          return vc
      }
    static func InterestBuild()-> UIViewController{
          let sb = Utilities.getStoryboard(identifier: Storyboards.dashboard.rawValue)
          let vc = sb.instantiateViewController(identifier: ViewControllersIdentifier.interest.rawValue) as! InterestViewController
          let viewModel = InterestViewModel()
          vc.viewModel = viewModel
          
          return vc
      }
    static func BookmarkBuild()-> UIViewController{
          let sb = Utilities.getStoryboard(identifier: Storyboards.dashboard.rawValue)
          let vc = sb.instantiateViewController(identifier: ViewControllersIdentifier.bookmark.rawValue) as! BookmarksViewController
          let viewModel = BookmarkViewModel()
          vc.viewModel = viewModel
          
          return vc
      }
    static func CategoriesBuilder()-> UIViewController{
          let sb = Utilities.getStoryboard(identifier: Storyboards.dashboard.rawValue)
          let vc = sb.instantiateViewController(identifier: ViewControllersIdentifier.categories.rawValue) as! CategoriesViewController
        let repo = CategoriesRepositoryImplementation()
        let viewModel = CategoriesViewModel(navigationType: .clearNavBar, repo : repo)
          vc.viewModel = viewModel
          return vc
      }
    static func TopStoriesBuild()-> UIViewController{
        let sb = Utilities.getStoryboard(identifier: Storyboards.dashboard.rawValue)
          let vc = sb.instantiateViewController(identifier: ViewControllersIdentifier.topStories.rawValue) as! TopStoriesViewController
        let viewModel = TopStoriesViewModel(navigationType: .clearNavBar)
          vc.viewModel = viewModel
          
          return vc
      }
    static func MyNewsBuilder()-> UIViewController{
          let sb = Utilities.getStoryboard(identifier: Storyboards.dashboard.rawValue)
          let vc = sb.instantiateViewController(identifier: ViewControllersIdentifier.myNews.rawValue) as! MyNewsViewController
          let viewModel = MyNewsViewModel()
          vc.viewModel = viewModel
          
          return vc
      }
    
    
    
    
}

