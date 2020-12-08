//
//  SplashViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 07/11/2020.
//

import UIKit

class SplashViewController: BaseViewController
{
    var viewModel : SplashViewModel!
    // MARK: View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navBarType = self.viewModel.getNavigationBar()
        for family: String in UIFont.familyNames
               {
                   print(family)
                   for names: String in UIFont.fontNames(forFamilyName: family)
                   {
                       print("== \(names)")
                   }
               }
    }
    override func viewDidAppear(_ animated: Bool) {
        navigate()
    }
    func navigate(){
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (_) in
            self.viewModel.checkUserState { (vc) in
                AppRouter.goToSpecificController(vc: vc)

            }
        }
//        self.viewModel.checkUserState { (vc) in
//            AppRouter.createInitialRoute(vc: vc)
//        }
    }
}
