//
//  SettingsViewModel.swift
//  Pulse
//
//  Created by Hamza Khan on 20/11/2020.
//

import Foundation
import UIKit

class SettingsViewModel
{
    let headerTitle = ""
    private let navBarType : navigationBarTypes!

    init(navigationType navBar : navigationBarTypes) {
        self.navBarType = navBar
    }
    func getNavigationBar()-> navigationBarTypes{
        return navBarType
    }
}
