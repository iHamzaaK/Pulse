//
//  SplashViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 07/11/2020.
//

import UIKit
import ViewAnimator
class SplashViewController: BaseViewController
{
    var viewModel : SplashViewModel!
    let fromAnimation = AnimationType.vector(CGVector(dx: 30, dy: 0))
    let zoomAnimation = AnimationType.zoom(scale: 0.5)

    @IBOutlet weak var imgViewLogo : UIImageView!
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblDescription : UILabel!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        navBarType = self.viewModel.getNavigationBar()
        UIView.animate(views: [self.imgViewLogo, lblTitle, lblDescription],
                       animations: [fromAnimation,zoomAnimation], delay: 0.5)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        navigate()
    }
    func navigate(){
        Timer.scheduledTimer(withTimeInterval: 3.5, repeats: false) { (_) in
            self.viewModel.checkUserState { (vc) in
                AppRouter.createInitialRoute(vc: vc)

            }
        }
//        self.viewModel.checkUserState { (vc) in
//            AppRouter.createInitialRoute(vc: vc)
//        }
    }
}
