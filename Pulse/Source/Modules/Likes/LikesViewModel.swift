//
//  LikesViewModel.swift
//  Pulse
//
//  Created by Hamza Khan on 02/12/2020.
//

import Foundation

class LikesViewModel {
  
        let headerTitle = ""
        private let navBarType : navigationBarTypes!

        init(navigationType navBar : navigationBarTypes) {
            self.navBarType = navBar
        }
        func getNavigationBar()-> navigationBarTypes{
            return navBarType
        }
       
}
