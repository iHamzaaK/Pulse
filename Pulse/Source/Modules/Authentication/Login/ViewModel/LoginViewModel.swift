//
//  LoginViewModel.swift
//  Pulse
//
//  Created by Hamza Khan on 07/11/2020.
//

import Foundation

class LoginViewModel{
    let headerTitle = ""
    private let navBarType : navigationBarTypes!

    init(navigationType navBar : navigationBarTypes) {
        self.navBarType = navBar
    }
    func getNavigationBar()-> navigationBarTypes{
        return navBarType
    }
}
