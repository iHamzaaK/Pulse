//
//  CreatePostViewModel.swift
//  Pulse
//
//  Created by Hamza Khan on 21/11/2020.
//

import UIKit

final class CreatePostViewModel {
  private let headerTitle = ""
  private let navBarType : navigationBarTypes!

  init(navigationType navBar : navigationBarTypes) {
    self.navBarType = navBar
  }

  func getNavigationBar()-> navigationBarTypes{
    return navBarType
  }
}
