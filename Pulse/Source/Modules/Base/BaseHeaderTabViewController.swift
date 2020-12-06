//
//  BaseHeaderTabViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 10/11/2020.
//

import UIKit

class BaseHeaderTabViewController: UITabBarController , HeaderViewDelegate,FooterViewDelegate {
    
    var _headerView:HeaderView!
    internal var viewsDictionary = Dictionary<String,AnyObject>()
    internal var constraints = [NSLayoutConstraint]()
    var headerViewHeight : CGFloat = 0
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        headerViewHeight = getHeaderFooterHeight()
        self.view.backgroundColor = UIColor.white
        let bundle = Bundle(for: type(of: self))
        let headerViewNibName = "HeaderView" + "-" + Utilities.getDeviceTypeStr()

        let nib = UINib(nibName: headerViewNibName, bundle: bundle)
        //        let nibF = UINib(nibName: "Footer", bundle: bundle)
        
        _headerView = nib.instantiate(withOwner: self, options: nil)[0] as! HeaderView
        
        _headerView.isOpaque = false
        //        _footerView = nibF.instantiate(withOwner: self, options: nil)[0] as! FooterView
        
        self.view.addSubview(self._headerView!)
        //   self.view.addSubview(self._footerView!)
        
        _headerView.delegate = self
        //      _footerView.delegate = self
        _headerView.bgImageContainer?.isRounded = true
//        _headerView.bgImageContainer?.layer.cornerRadius = 20
        configureHeaderViewConstraints()
        
        self .updateHeaderWithHeadingText(hText: "", rightBtnImageName: "", leftBtnImageName: "", backgroundImageName: "", bgColor: "")
        
        
        
        //        self .updateFooterWithHeadingText(hText: "", rightBtnImageName: "", leftBtnImageName:"", backgroundImageName: "", bgColor: "")
        
        //     _footerView.isHidden = true
        
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupHeader(title : String , strImage : String){
        _headerView.lblHeading?.text = title
        _headerView.leftButtonImage = strImage
        
    }
    func loadWithNib(nibName:String, viewIndex:Int, owner: AnyObject) -> Void {
        let headerNib : UIView = Bundle.main.loadNibNamed(nibName, owner: owner, options: nil)?.first as! UIView
        headerNib.frame = CGRect( x : 0, y: 0, width :  self.view.frame.width, height : 200)
        self.view.addSubview(headerNib)
    }
    
    public func updateHeaderWithHeadingText(hText: String, rightBtnImageName: String, leftBtnImageName: String, backgroundImageName: String, bgColor: String  ) -> Void {
        _headerView.updateHeaderWithHeadingText(hText: hText, rightBtnImageName: rightBtnImageName, leftBtnImageName: leftBtnImageName, backgroundImageName:backgroundImageName, bgColor: bgColor);
        
    }
    
    
    
    //    public func updateFooterWithHeadingText(hText: String, rightBtnImageName: String, leftBtnImageName: String, backgroundImageName: String, bgColor: String  ) -> Void {
    //
    //        _footerView.updateFooterWithHeadingText(hText: hText, rightBtnImageName: rightBtnImageName, leftBtnImageName: leftBtnImageName, bgColor: bgColor);
    //    }
    
    enum leftRightMenu : Int {
        case left = 0
        case right
    }
    
    func checkBackFunction(headerView: HeaderView, openLeftOrRight : leftRightMenu ){
        if headerView == self._headerView {
            //print("leftButtonClicked")
            if openLeftOrRight == .left {
                if(self._headerView.leftButtonImage != ""){
                    if self._headerView.leftButtonImage == "menuIcon" {
                        //
                    }
                    else{
                        self.navigationController!.popViewController(animated: true)
                        
                    }
                }
                else{
                    self.navigationController!.popViewController(animated: true)
                }
            }
            else{
                if(self._headerView.rightButtonImage != ""){
                    if self._headerView.rightButtonImage == "menuIcon" {
                        AppRouter.showHideRightMenu()
                    }
                    else{
                        self.navigationController!.popViewController(animated: true)
                    }
                }
            }
            
        }
        else{
            //print("leftButtonClicked footer")
        }
        
    }
    func headerViewLeftBtnDidClick(headerView: HeaderView) {
        checkBackFunction(headerView: headerView, openLeftOrRight: .left)
    }
    
    func headedrViewSearchTextChanged(str: String) {
        //print(str)

    }
    
    func headerViewRightSecondaryBtnDidClick(headerView: HeaderView) {
        
        
    }
    func headerViewRightBtnDidClick(headerView: HeaderView) {
        //print("rightButtonClicked")
        checkBackFunction(headerView: headerView, openLeftOrRight: .right)
    }
    func configureHeaderViewConstraints(){
        if ( Device.IS_IPHONE_X){
            _headerView.bottomConstraintHeading?.constant = 25
            _headerView.bottomConstraintTextField?.constant = 15

        }
        viewsDictionary["headerView"] = _headerView
        
        _headerView.translatesAutoresizingMaskIntoConstraints = false
        //   _footerView.translatesAutoresizingMaskIntoConstraints = false
        
        let strVConstraints = "V:|-0-[headerView(\(headerViewHeight))]"
        
        
        let strHConstraints = "H:|-0-[headerView]-0-|"
        
        
        // viewsDictionary["footerView"] = _footerView
        
        _headerView.translatesAutoresizingMaskIntoConstraints = false
        
        //let strVConstraintsfooterView = "V:[footerView(\(headerViewHeight+20))]-0-|"
        
        
        //    let strHConstraintsfooterView = "H:|-0-[footerView]-0-|"
        
        
        setConstraintsForHeader(format: strVConstraints)
        setConstraintsForHeader(format: strHConstraints)
        //    setConstraintsForHeader(format: strVConstraintsfooterView)
        //  setConstraintsForHeader(format: strHConstraintsfooterView)
        
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    
    func setConstraintsForHeader(format : String){
        
        let newConstraint = NSLayoutConstraint.constraints(withVisualFormat: format, options:[], metrics: nil, views: viewsDictionary)
        constraints += newConstraint
        
    }
    override public var prefersStatusBarHidden: Bool {
        return true
    }
    
    func getHeaderFooterHeight() -> CGFloat{
        return Utilities.getHeaderHeight()
    }
}
