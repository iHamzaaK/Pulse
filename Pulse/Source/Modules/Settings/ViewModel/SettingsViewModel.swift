//
//  SettingsViewModel.swift
//  Pulse
//
//  Created by Hamza Khan on 20/11/2020.
//

import UIKit

final class SettingsViewModel {
  private let headerTitle = ""
  private let navBarType : navigationBarTypes
  let profileRepo : UserProfileRepository

  init(navigationType navBar : navigationBarTypes, repo : UserProfileRepository) {
    self.navBarType = navBar
    self.profileRepo = repo
  }

  func getNavigationBar()-> navigationBarTypes{
    return navBarType
  }
  
  func updateProfile(switchFlag : Bool, completionHandler: @escaping( _ isSuccess : Bool , _ serverMsg: String)->Void){
    let flag = switchFlag.intValue

    let params = ["notificationOn": String(flag)]

    self.profileRepo.changeUserProfile(params: params, avatar: nil) { (success, serverMsg) in
      completionHandler(success,serverMsg)
    }

  }
}
