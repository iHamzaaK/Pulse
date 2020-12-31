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
        delegate = self
        _headerView.bgColorVar = "cc"
//        _headerView.leftButtonImage = "notification-icon"
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
        createViewControllers()

        navBarType = self.viewModel.getNavigationBar()
        NotificationCenter.default.addObserver(self, selector: #selector(self.openCreatePost), name: Notification.Name("createPost"), object: nil)
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.selectedIndex = 0
    }
    
    @objc func openCreatePost(){
        self.present(CreatePostBuilder.build(), animated: true) {
            
        }
    }
    override func headedrViewSearchTextChanged(str: String) {
        //print(str)
    }
    func createViewControllers(){
        let topStoriesVC = ArticleListingBuilder.build(title: "Top Stories", type: .topStories, categoryId: nil, navBarType: .clearNavBar)
        topStoriesVC.tabBarItem = UITabBarItem(title: "Top Stories", image: Utilities.getImage(str: "outlined-Logo-1"), selectedImage: Utilities.getImage(str: "filled-top-stories-logo"))
        let categoriesVC = DashboardBuilder.CategoriesBuilder()
        categoriesVC.tabBarItem = UITabBarItem(title: "Categories", image: Utilities.getImage(str: "outlined-categories-icon-1"), selectedImage: Utilities.getImage(str: "filled-categories-icon-"))
        
        let myNews = DashboardBuilder.MyNewsBuilder()//ArticleListingBuilder.build(title: "My News", type: .myNews, categoryId: nil)
        myNews.tabBarItem = UITabBarItem(title: "My News", image: Utilities.getImage(str: "outlined-my-news-icon-1"), selectedImage: Utilities.getImage(str: "filled-my-news-icon"))

        
        let navigationController1 = UINavigationController(rootViewController: topStoriesVC)
        navigationController1.setNavigationBarHidden(true, animated: false)
        let navigationController2 = UINavigationController(rootViewController: myNews)
        navigationController2.setNavigationBarHidden(true, animated: false)
        let navigationController3 = UINavigationController(rootViewController: categoriesVC)
        navigationController3.setNavigationBarHidden(true, animated: false)

        self.viewControllers = [navigationController1, navigationController2,navigationController3]
//


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
extension DashboardViewController: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
