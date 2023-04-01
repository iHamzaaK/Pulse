//
//  MyProfileBuilder.swift
//  Pulse
//
//  Created by Hamza Khan on 19/11/2020.
//

import UIKit

final class MyProfileBuilder {
  static func build()-> UIViewController{
    let sb = Utilities.getStoryboard(identifier: Storyboards.myProfile.rawValue)
    let vc = sb.instantiateViewController(identifier: ViewControllersIdentifier.myProfile.rawValue) as! MyProfileViewController
    let navBarType = navigationBarTypes.backButtonWithRightMenuButton
    let categoryRepo = CategoriesRepositoryImplementation()
    let profileRepo = UserProfileRepositoryImplementation()
    let viewModel = MyProfileViewModel(navigationType: navBarType, userData: ArchiveUtil.getUser(), catData: ArchiveUtil.getCategories(),profileRepo: profileRepo,categoriesRepo: categoryRepo)
    vc.viewModel = viewModel
    return vc
  }
}
