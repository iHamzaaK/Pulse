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
  private static var rightMenuWidth: CGFloat = 0.8
  private static var navController : BaseNavigationViewController = BaseNavigationViewController()

  static var slideMenu : SlideMenuController!{
    didSet{
      if DesignUtility.isIPad{
        rightMenuWidth = 0.45
      }
      slideMenu.changeRightViewWidth(UIScreen.main.bounds.width * rightMenuWidth)
      SlideMenuOptions.panFromBezel = false
      SlideMenuOptions.rightPanFromBezel = false
      SlideMenuOptions.contentViewScale = 1.0
    }
  }

  static func createRoute(window : UIWindow) {
    SlideMenuOptions.opacityViewBackgroundColor = .white
    self.window = window
    self.window!.backgroundColor = UIColor.white
    let vc : UIViewController! =  SplashBuilder.build()
    self.navController.navigationBar.isHidden = true
    self.navController.viewControllers = [vc]
    let rightVC = RightMenuBuilder.build()
    slideMenu = SlideMenuController(mainViewController: self.navController, rightMenuViewController: rightVC)
    self.window?.rootViewController = slideMenu
    self.window?.makeKeyAndVisible()
  }

  static func createInitialRoute(vc: UIViewController){
    self.navController.viewControllers = [vc]
  }

  static func showHideRightMenu(){
    if slideMenu.isRightOpen(){
      slideMenu.closeRight()
    } else{
      slideMenu.openRight()
    }
  }

  static func pop(){
    slideMenu.closeRight()
    self.navController.popViewController(animated: true);

  }

  static func logout(){
    slideMenu.closeRight()
    self.createInitialRoute(vc: LoginBuilder.build())
    ArchiveUtil.deleteSession()

  }

  static func goToLogin(){
    if slideMenu.isRightOpen(){
      slideMenu.closeRight()
    }
    let loginVC = LoginBuilder.build()
    self.navController.viewControllers = [loginVC]
  }

  static func goToHomeFromRightMenu(){
    slideMenu.closeRight()

    self.navController.popToRootViewController(animated: true)

  }

  static func goToSpecificController(vc : UIViewController){
    slideMenu.closeRight()

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

  static func presentControllerForNotification(vc: UIViewController){
    slideMenu.closeRight()
    let navigationCont = UINavigationController.init()
    navigationCont.navigationBar.isHidden = true
    navigationCont.viewControllers = [vc]
    self.window?.rootViewController?.present(navigationCont, animated: true, completion: {})
  }
}

