//
//  RghtMenuBuilder.swift
//  Halal
//
//  Created by Hamza Khan on 19/11/2019.
//  Copyright © 2019 Hamza. All rights reserved.
//

import UIKit

class RightMenuBuilder{
     static func build()-> UIViewController{
           let sb = Utilities.getStoryboard(identifier: Storyboards.rightMenu.rawValue)
           let vc = sb.instantiateViewController(identifier: ViewControllersIdentifier.rightMenu.rawValue) as! RightMenuViewController
           let navBarType = navigationBarTypes.clearNavBar
           let rightMenuViewModel = RightMenuViewModel(navigationType: navBarType)
           vc.viewModel = rightMenuViewModel
           
           return vc
       }
}
