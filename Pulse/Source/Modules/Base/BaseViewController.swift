//
//  BaseViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 07/11/2020.
//

import UIKit
import SlideMenuControllerSwift

enum navigationBarTypes{
  case clearNavBar
  case searchNavBar
  case profileWithMenu
  case backButtonWithRightMenuButton
  case backButtonWithTitle
  case leftRightButtonsWithLogo
  case filterNavBar

}

protocol NavigationBarButtonProtocols: AnyObject {
  func didTapOnLeftBtn()->Void
  func didTapOnRightBtn()->Void
  func didChangeValueInSearchTextfield()->Void
  func didTapOnProfileImage()->Void
}

class BaseViewController: HeaderViewController{
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
}

extension BaseViewController{
  func setTitleForHeader(text : String){
    _headerView.heading = text
  }
}

extension BaseViewController {
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
      self.setupleftRightButtonsWithLogo()
      break
    case .filterNavBar:
      self.setupFilterNavBar()
    }
  }
  private func clearNavBar(){
    _headerView.isHidden = true
  }

  private func setupNavigation(){
    view.addSubview(navBar)
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.isTranslucent = true
  }

  private func setupSearchNavBar(){
    self.createSearchTextField()
    _headerView.leftButtonImage = "search-close-icon"
    _headerView.rightButtonImage = "icon-filter"
    _headerView.rightSecondaryButtonImage = ""

  }

  private func setupProfleWithMenu(){
    self.createRightBarButton()
    _headerView.bgImageContainer?.isHidden = false
    _headerView.lblHeading?.isHidden = true


  }

  private func setupBackButtonWithRightOptionsButton(){
    self.createLeftBarButton()
    self.createRightBarButton()
    _headerView.bgImageContainer?.isHidden = false


  }

  private func setupBackButtonWithTitle(){
    self.createLeftBarButton()
    _headerView.bgImageContainer?.isHidden = false

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
    _headerView.leftButtonImage = ""
    _headerView.bgImageContainer?.isHidden = false
  }

  private func setupFilterNavBar(){
    _headerView.leftButtonImage = "search-close-icon"
    _headerView.bgImageContainer?.isHidden = true
  }

  private func createSearchTextField(){
    _headerView.searchTextField?.isHidden = false
    _headerView.bgImageContainer?.isHidden = true
    _headerView.btnRight?.isHidden = false
    _headerView.rightButtonImage = "menu"
    _headerView.btnLeft?.isHidden = false
    _headerView.leftButtonImage = "notification-icon"
  }

  @objc func didEditText(textField : BaseUITextfield){}
}

