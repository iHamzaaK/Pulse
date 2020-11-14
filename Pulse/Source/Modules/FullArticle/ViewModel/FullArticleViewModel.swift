//
//  FullArticleViewModel.swift
//  Pulse
//
//  Created by Hamza Khan on 10/11/2020.
//

import Foundation
import UIKit

class FullArticleViewModel
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
