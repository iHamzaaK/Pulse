//
//  ProfileViewModel.swift
//  Pulse
//
//  Created by Hamza Khan on 19/11/2020.
//

import Foundation
import UIKit

class MyProfileViewModel
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
