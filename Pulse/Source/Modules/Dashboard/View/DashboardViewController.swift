//
//  DashboardViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 08/11/2020.
//

import UIKit

class DashboardViewController: BaseTabBarViewController {

    var viewModel: DashboardViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.shadowImage = UIImage()
        tabBar.layer.borderWidth = 0
        tabBar.layer.borderColor = UIColor.white.cgColor
        let tabBarView = UIImageView(image: #imageLiteral(resourceName: "footer-bg"))
        tabBarView.frame = CGRect(x: 0, y: 0, width: Device.SCREEN_WIDTH, height: 100)
        self.tabBar.addSubview(tabBarView)
        self.tabBar.sendSubviewToBack(tabBarView)
        navBarType = self.viewModel.getNavigationBar()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
