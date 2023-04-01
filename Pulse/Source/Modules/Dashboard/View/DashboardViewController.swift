//
//  DashboardViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 08/11/2020.
//

import UIKit

final class DashboardViewController: BaseTabBarViewController {
  fileprivate lazy var defaultTabBarHeight = { tabBar.frame.size.height }()
  var homePage = 2
  var viewModel: DashboardViewModel!
  var previousController: UIViewController?

  override func viewDidLoad() {
    super.viewDidLoad()
    delegate = self
    _headerView.bgColorVar = "cc"
    tabBar.layer.masksToBounds = false
    tabBar.layer.borderWidth = 1
    tabBar.layer.borderColor = UIColor.white.cgColor
    tabBar.isTranslucent = true
    tabBar.barStyle = .black
    tabBar.layer.cornerRadius = 20
    tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    tabBar.shadowImage = UIImage()
    tabBar.backgroundImage = UIImage()
    tabBar.backgroundColor = UIColor.white
    // Add only shadow
    tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
    tabBar.layer.shadowRadius = 8
    tabBar.layer.shadowColor = Utilities.hexStringToUIColor(hex: "009ED4").cgColor
    tabBar.layer.shadowOpacity = 0.2

    createViewControllers()
    navBarType = self.viewModel.getNavigationBar()
    NotificationCenter.default.addObserver(self, selector: #selector(self.openCreatePost), name: Notification.Name("createPost"), object: nil)
    self.selectedIndex = homePage
    NotificationCenter.default.addObserver(self, selector: #selector(self.showMainPage), name: Notification.Name(rawValue: "showHome"), object: nil)

  }

  override func viewDidLayoutSubviews() {
    let newTabBarHeight = defaultTabBarHeight + DesignUtility.convertToRatio(10.0, sizedForIPad: DesignUtility.isIPad, sizedForNavi: false)
    var newFrame = tabBar.frame
    newFrame.size.height = newTabBarHeight
    newFrame.origin.y = view.frame.size.height - newTabBarHeight

    tabBar.frame = newFrame
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    NotificationCenter.default.post(name: Notification.Name(rawValue: "reloadListing"), object: nil, userInfo: nil)
    viewModel.getCountries()
  }

  @objc func openCreatePost(){
    self.present(CreatePostBuilder.build(), animated: true)
  }

  @objc func showMainPage(){
    self.selectedIndex = homePage
  }

  override func headedrViewSearchTextChanged(str: String) {}

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
  }
}

extension DashboardViewController: UITabBarControllerDelegate{
  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    if previousController == viewController {
      if let navVC = viewController as? UINavigationController{
        if let vc = navVC.viewControllers.first as? ArticleListingViewController {
          if vc.isViewLoaded && (vc.view.window != nil) {
            vc.scrollToTop()
          }
        }
        if let vc = navVC.viewControllers.first as? CategoriesViewController{
          if vc.isViewLoaded && (vc.view.window != nil) {
            vc.scrollToTop()
          }
        }
      }
    }
    previousController = viewController
    return true;
  }
  
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {}
}
