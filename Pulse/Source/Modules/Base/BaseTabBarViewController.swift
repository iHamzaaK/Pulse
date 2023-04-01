//
//  BaseTabBarViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 10/11/2020.
//

import UIKit
import SlideMenuControllerSwift


class BaseTabBarViewController: BaseHeaderTabViewController{

  var navBar = UINavigationBar()
  var slideMenu = SlideMenuController()
  private var navColor : UIColor = UIColor.clear
  weak var navDelegate : NavigationBarButtonProtocols?
  var navBarType : navigationBarTypes = .backButtonWithTitle{
    didSet{
      setupNavBar()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func headerViewRightSecondaryBtnDidClick(headerView: HeaderView) {
    let vc = SearchBuilder.build()
    vc.modalPresentationStyle = .overCurrentContext
    self.present(vc, animated: false)
  }
}

extension BaseTabBarViewController{
  func setTitleForHeader(text : String){
    _headerView.heading = text

  }
}

extension BaseTabBarViewController {
  private func setupNavBar(){
    switch navBarType {
    case .clearNavBar:
      self.clearNavBar()
      break
    case .searchNavBar:
      self.setupSearchNavBar()
      break
    case .profileWithMenu:
      self.setupProfleWithMenu()
      break
    case .backButtonWithRightMenuButton:
      self.setupBackButtonWithRightOptionsButton()
      break
    case .backButtonWithTitle:
      self.setupBackButtonWithTitle()
      break
    case .leftRightButtonsWithLogo:
      setupleftRightButtonsWithLogo()
      break
    case .filterNavBar:
      self.setupFilterNavBar()
    }
  }

  private func clearNavBar(){
    _headerView.isHidden = true
  }

  private func setupNavigation(){
    //        setNavigationBarColor(color: appColors.green.colorStatus)
    view.addSubview(navBar)
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.isTranslucent = true
  }

  private func setupSearchNavBar(){
    self.createSearchTextField()
    _headerView.leftButtonImage = "search-close-icon"
  }

  private func setupProfleWithMenu(){
    self.createRightBarButton()
    _headerView.bgImageContainer?.isHidden = false
    _headerView.lblHeading?.isHidden = true
  }

  private func setupFilterNavBar(){
    createRightBarButton()
    _headerView.btnRight?.setTitle("Done", for: .normal)
    _headerView.leftButtonImage = "search-close-icon"
    _headerView.bgImageContainer?.isHidden = false
    _headerView.btnRight?.isHidden = false

  }

  private func setupBackButtonWithRightOptionsButton(){
    self.createLeftBarButton()
    self.createRightBarButton()
    _headerView.bgImageContainer?.isHidden = false
  }

  private func setupBackButtonWithTitle(){
    self.createLeftBarButton()
  }

  private func createLeftBarButton(){
    _headerView.leftButtonImage = "backIcon"

  }

  private func createRightBarButton(){
    _headerView.rightButtonImage = "menuIcon"
  }

  private func setupleftRightButtonsWithLogo(){
    _headerView.rightSecondaryButtonImage = "seach-1x"
    createRightBarButton()
    _headerView.leftButtonImage = "notification-icon"
    _headerView.bgImageContainer?.isHidden = false
  }

  private func createSearchTextField(){
    _headerView.searchTextField?.isHidden = true
    _headerView.bgImageContainer?.isHidden = true
  }

  @objc func didEditText(textField : BaseUITextfield){}
}

