//
//  TopStoriesViewModel.swift
//  Pulse
//
//  Created by Hamza Khan on 08/11/2020.
//

import Foundation
import UIKit

class TopStoriesViewModel
{
    let headerTitle = ""
    private let navBarType : navigationBarTypes!

    init(navigationType navBar : navigationBarTypes) {
        self.navBarType = navBar
    }
    func getNavigationBar()-> navigationBarTypes{
        return navBarType
    }
    func getItemHeight(row : Int)-> CGSize{
        var width  = UIScreen.main.bounds.width
        var height : CGFloat = 200.0
        if  DesignUtility.isIPad{
            height = 415
        }
        height = DesignUtility.convertToRatio(height, sizedForIPad: DesignUtility.isIPad, sizedForNavi: false)
        
        if row != 0 {
            width = UIScreen.main.bounds.width/2 - 2
            height = width
        }
            return CGSize(width: width, height: height)
    }
   
}
