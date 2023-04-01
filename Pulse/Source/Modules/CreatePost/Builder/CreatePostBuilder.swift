//
//  CreatePostBuilder.swift
//  Pulse
//
//  Created by Hamza Khan on 21/11/2020.
//

import UIKit

final class CreatePostBuilder {
  static func build()-> UIViewController{
    let sb = Utilities.getStoryboard(identifier: Storyboards.createPost.rawValue)
    let vc = sb.instantiateViewController(identifier: ViewControllersIdentifier.createPost.rawValue) as! CreatePostViewController
    let navBarType = navigationBarTypes.clearNavBar
    let viewModel = CreatePostViewModel(navigationType: navBarType)
    vc.viewModel = viewModel
    return vc
  }
}
