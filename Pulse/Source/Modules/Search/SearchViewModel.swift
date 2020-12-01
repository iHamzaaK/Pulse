//
//  SearchViewModel.swift
//  Pulse
//
//  Created by Hamza Khan on 27/11/2020.
//

import Foundation
class SearchViewModel
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
