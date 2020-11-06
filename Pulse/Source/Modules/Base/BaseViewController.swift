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
    case backButtonWithRightOptionsButton
    case backButtonWithTitle
}
protocol navigationBarButtonProtocols: class{
    func didTapOnLeftBtn()->Void
    func didTapOnRightBtn()->Void
    func didChangeValueInSearchTextfield()->Void
    func didTapOnProfileImage()->Void
}

class BaseViewController: HeaderViewController{
    
    private var hideLeftButton : Bool = false
    private var hideRightButton : Bool = false
    private var hideTitleImage : Bool = false
    private var hideTitleLabel : Bool = false
    private var hideTitleSearch : Bool = false
    var navBar = UINavigationBar()
    private var navColor : UIColor = UIColor.clear
    private lazy var leftBarButton : BaseUIButton = BaseUIButton()
    private lazy var rightBarButton : BaseUIButton = BaseUIButton()
    private lazy var lblTitle : UILabel = UILabel()
    private lazy var searchBarTitle : BaseUITextfield = BaseUITextfield()
    private lazy var profileButton : BaseUIButton = BaseUIButton()
    lazy var logoImageView : BaseUIImageView = BaseUIImageView()
    weak var navDelegate : navigationBarButtonProtocols?
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
    private var strTitleText = ""
    var navBarType : navigationBarTypes = .backButtonWithTitle{
        didSet{
            setupNavBar()
        }
    }
    var slideMenu = SlideMenuController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        
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
        case .backButtonWithRightOptionsButton:
            self.setupBackButtonWithRightOptionsButton()
            break
        case .backButtonWithTitle:
             self.setupBackButtonWithTitle()
            break
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

    }
    private func setupProfleWithMenu(){
        self.createRightBarButton()
        _headerView.bgImageContainer?.isHidden = false
        _headerView.lblHeading?.isHidden = true

        
    }
    private func setupBackButtonWithRightOptionsButton(){
        self.createLeftBarButton()
        self.createRightBarButton()
        
    }
    private func setupBackButtonWithTitle(){
        self.createLeftBarButton()
        self.createTitleLabel()
    }
    
    private func createLeftBarButton(){
        _headerView.leftButtonImage = "back"
 
    }
    private func createRightBarButton(){
        _headerView.rightButtonImage = "menu"
    }
    private func createTitleImage(){
    }
    private func createTitleLabel(){
    }
    private func createSearchTextField(){
        _headerView.searchTextField?.isHidden = false
        _headerView.bgImageContainer?.isHidden = true
        _headerView.btnRight?.isHidden = false
        _headerView.rightButtonImage = "menu"
        _headerView.btnLeft?.isHidden = false
        _headerView.leftButtonImage = "back"
    }
    @objc func didEditText(textField : BaseUITextfield){
    }
    @objc func imageTapped(sender: BaseUIButton){
    }
    
}

