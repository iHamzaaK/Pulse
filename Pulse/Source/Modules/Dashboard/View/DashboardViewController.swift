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
        _headerView.bgColorVar = "cc"   
//        self.tabBar.backgroundImage = UIImage()
//        self.tabBar.shadowImage = UIImage()
//        tabBar.layer.borderWidth = 0
//        tabBar.layer.borderColor = UIColor.clear.cgColor
//        let tabBarView = UIImageView(image: #imageLiteral(resourceName: "footer-bg"))
//        tabBarView.frame = CGRect(x: 0, y: 0, width: Device.SCREEN_WIDTH, height: 100)
//        self.tabBar.addSubview(tabBarView)
//        self.tabBar.sendSubviewToBack(tabBarView)
        self.tabBar.layer.masksToBounds = true
                tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.lightGray.cgColor

        self.tabBar.isTranslucent = true
        self.tabBar.barStyle = .black
        self.tabBar.layer.cornerRadius = 20
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        navBarType = self.viewModel.getNavigationBar()
        NotificationCenter.default.addObserver(self, selector: #selector(self.openCreatePost), name: Notification.Name("createPost"), object: nil)
        // Do any additional setup after loading the view.
        
    }
    
    @objc func openCreatePost(){
        self.present(CreatePostBuilder.build(), animated: true) {
            
        }
    }
    override func headedrViewSearchTextChanged(str: String) {
        print(str)
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
