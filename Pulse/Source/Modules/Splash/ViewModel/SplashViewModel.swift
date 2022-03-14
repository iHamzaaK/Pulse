//
//  SplashViewModel.swift
//  Pulse
//
//  Created by Hamza Khan on 07/11/2020.
//

import Foundation
import UIKit

class SplashViewModel
{
    let headerTitle = ""
    private let navBarType : navigationBarTypes!
    
    init(navigationType navBar : navigationBarTypes) {
        self.navBarType = navBar
    }
    func getNavigationBar()-> navigationBarTypes{
        return navBarType
    }
    
    
    func checkUserState(completionHandler : @escaping (_ vc : UIViewController)->()){

        var vc : UIViewController! =  LoginBuilder.build()
        if ArchiveUtil.getUserToken() != ""{
            NotificationCenter.default.post(name: Notification.Name("updateUserImage"), object: nil)
            vc = DashboardBuilder.build()

        }
        else{
            vc  = LoginBuilder.build()
        }
      completionHandler(vc)
    }
    
}
