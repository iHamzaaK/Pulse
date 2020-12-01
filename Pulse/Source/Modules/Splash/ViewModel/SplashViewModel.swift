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
//            let dashboardRepo = DashboardRepositoryImplementation()
//            dashboardRepo.getDashboardData { (isSuccess, serverMsg, data) in
//                if isSuccess{
//                    guard let data = data else { return }
//                    vc = DashboardBuilder.build(dashboardRepo: data)
//                    completionHandler(vc)
//                }
//                else{
            
//                    vc  = LoginBuilder.build()
//                    completionHandler(vc)
//                }
//            }
        }
        else{
            vc  = LoginBuilder.build()
            completionHandler(vc)
        }
        
        
        
    }
    
}
