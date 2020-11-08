//
//  ForgetPassword.swift
//  Pulse
//
//  Created by Hamza Khan on 07/11/2020.
//

import Foundation
class ForgetPasswordViewModel{
    let headerTitle = "Forget Password"
    private let navBarType : navigationBarTypes!

    init(navigationType navBar : navigationBarTypes) {
        self.navBarType = navBar
    }
    func getNavigationBar()-> navigationBarTypes{
        return navBarType
    }
}
