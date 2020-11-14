//
//  AppRouter.swift
//  Halal
//
//  Created by hamza Ahmed on 16.10.19.
//  Copyright © 2019 Hamza. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
class AppRouter{
    private static var window : UIWindow?
    private static var navController : BaseNavigationViewController = BaseNavigationViewController()
    static var slideMenu : SlideMenuController!{
        didSet{
            slideMenu.changeRightViewWidth(UIScreen.main.bounds.width * 0.8)
            SlideMenuOptions.panFromBezel = false
            SlideMenuOptions.rightPanFromBezel = false
            SlideMenuOptions.contentViewScale = 1.0
        }
    }
    static func createRoute(window : UIWindow) {
        SlideMenuOptions.opacityViewBackgroundColor = .white
        self.window = window
        self.window!.backgroundColor = UIColor.white
        let vc : UIViewController! =  FullArticleBuilder.build()
        self.navController.navigationBar.isHidden = true
        self.navController.viewControllers = [vc]
        let rightVC = RightMenuBuilder.build()
        slideMenu = SlideMenuController(mainViewController: self.navController, rightMenuViewController: rightVC)
        self.window?.rootViewController = slideMenu
        self.window?.makeKeyAndVisible()
        //
        
    }
    static func createInitialRoute(vc: UIViewController){
        self.navController.viewControllers = [vc]
    }
    
    static func showHideRightMenu(){
        if slideMenu.isRightOpen(){
            slideMenu.closeRight()
        }
        else{
            slideMenu.openRight()
        }
    }
    static func pop(){
        slideMenu.closeRight()
        self.navController.popViewController(animated: true);
        
    }
    static func logout(){
        slideMenu.closeRight()
        let loginVC = LoginBuilder.build()
        self.navController.viewControllers = [loginVC]
        //        ArchiveUtil.deleteSession()
        
    }
    static func goToLogin(){
        if slideMenu.isRightOpen(){
            slideMenu.closeRight()
        }
        let loginVC = LoginBuilder.build()
        self.navController.viewControllers = [loginVC]
    }
    static func goToSpecificController(vc : UIViewController){
        if slideMenu.isRightOpen(){
            slideMenu.closeRight()
        }
        let stackVCs = self.navController.viewControllers
        
        if self.navController.visibleViewController?.restorationIdentifier != vc.restorationIdentifier{
            if stackVCs.contains(vc){
                self.navController.popToViewController(vc, animated: true)
            }
            else{
                self.navController.pushViewController(vc, animated: true)
            }
        }
        
    }
    //    static func checkSignupStepsAndReroute()->UIViewController?{
    //        let step = ArchiveUtil.checkSignupStep()
    //        let signupStep = SignUpSteps(rawValue: step)
    //        var vc : UIViewController!
    //        switch signupStep {
    //        case .step1:
    //             vc = SignUpBuilder.buildCompanyStepOne()
    //            return vc
    //        case .step2:
    //            vc = SignUpBuilder.buildCompanyStepTwo()
    //            return vc
    //
    //        case .step3:
    //            vc = SignUpBuilder.buildCompanyStepThree()
    //            return vc
    //        default:
    //            return nil
    //        }
    //    }
    //    static func goToUserDashboard(dashboardData : DashboardRepo){
    //        let dashboardVC = DashboardBuilder.build(dashboardRepo: dashboardData)
    //        self.navController.viewControllers = [dashboardVC]
    //    }
    //    static func goToRestaurantDetail(restaurantId : Int){
    //        let navBarType = navigationBarTypes.backButtonWithRightOptionsButton
    //        let vc: UIViewController = RestaurantDetailBaseBuilder.build(navBarType: navBarType, restaurantId: restaurantId)
    //        self.navController.viewControllers = [vc]
    //    }
}

