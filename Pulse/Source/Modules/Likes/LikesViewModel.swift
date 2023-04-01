//
//  LikesViewModel.swift
//  Pulse
//
//  Created by Hamza Khan on 02/12/2020.
//

import Foundation

struct LikesCellViewModel{
  let name : String
  let image: String

  func getImageURL()->URL?{
    guard let url = URL.init(string: image) else { return nil}
    return url
  }
}

final class LikesViewModel {
  private let headerTitle = ""
  private let userLikeArr : [AllLikesData]
  private let navBarType : navigationBarTypes

  init(navigationType navBar : navigationBarTypes, userLikeArr : [AllLikesData]) {
    self.navBarType = navBar
    self.userLikeArr = userLikeArr
  }

  func getNavigationBar()-> navigationBarTypes{
    return navBarType
  }

  func getUserLikeArrCount()->Int{
    return userLikeArr.count
  }

  func cellViewModelForRow(row: Int)-> LikesCellViewModel{
    let userLike = userLikeArr[row]
    let cellViewModel = LikesCellViewModel(name: userLike.name ?? "", image: userLike.userImage ?? "")
    return cellViewModel
  }
}
