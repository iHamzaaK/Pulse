//
//  DashboardViewModel.swift
//  Pulse
//
//  Created by Hamza Khan on 08/11/2020.
//

import UIKit

final class DashboardViewModel {
  let headerTitle = ""
  private let navBarType : navigationBarTypes!
  private let repository: CountriesRepository!

  init(navigationType navBar : navigationBarTypes, repo: CountriesRepository) {
    self.navBarType = navBar
    self.repository = repo
  }

  func getNavigationBar()-> navigationBarTypes{
    return navBarType
  }

  func getCountries() {
    self.repository.getCountries { success, serverMsg, content in
      if success {
        // store repository
        ArchiveUtil.saveCountries(countries: content)
      }
    }
  }

}
