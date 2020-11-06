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
        self.view.backgroundColor = .orange
    }
    override func viewDidAppear(_ animated: Bool) {
        navigate()
    }
    func navigate(){
//        self.viewModel.checkUserState { (vc) in
//            AppRouter.createInitialRoute(vc: vc)
//        }
    }
}
