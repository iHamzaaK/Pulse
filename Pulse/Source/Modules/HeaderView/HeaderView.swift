//
//  HeaderView.swift
//  Skeleton
//
//  Created by Waqas Ali on 12/07/2016.
//  Copyright © 2016 My Macbook Pro. All rights reserved.
//

import UIKit


@objc protocol HeaderViewDelegate : class {
    @objc optional func headerViewLeftBtnDidClick(headerView : HeaderView) -> Void
    @objc optional func headerViewRightBtnDidClick(headerView : HeaderView) -> Void
    @objc optional func headerViewRightSecondaryBtnDidClick(headerView : HeaderView) -> Void

    @objc optional func headedrViewSearchTextChanged(str: String)->Void
}
public class HeaderView: UIView, UITextFieldDelegate {
    weak var delegate: HeaderViewDelegate?
    @IBOutlet weak var leadingConstraintLeftBtn : NSLayoutConstraint?
    @IBOutlet weak var trailingConstraintRightBtn : NSLayoutConstraint?
    @IBOutlet weak var bottomConstraintHeading : NSLayoutConstraint?
    @IBOutlet weak var bottomConstraintTextField : NSLayoutConstraint?
    @IBOutlet weak var bgImageContainer: BaseUIImageView?
    @IBOutlet weak var lblHeading: UILabel?
    @IBOutlet weak var imgHeading: UIImageView?
    @IBOutlet weak var btnLeft: UIButton?
    @IBOutlet weak var btnRight: UIButton?
    @IBOutlet weak var btnRightSecondary: UIButton?
    @IBOutlet weak var searchTextField: BaseUITextfield?{
        didSet{
            searchTextField?.addTarget(self, action: #selector(self.textfieldValueChanged(sender:)), for: .editingChanged)
            searchTextField?.delegate = self
            searchTextField?.placeholder = "Search News"

        }
    }

    @IBOutlet var viewContainer: UIView?
    private var _leftButtonImage : String? = nil
    var leftButtonImage : String?{
        didSet
        {
            if (leftButtonImage != nil && (leftButtonImage  == _leftButtonImage))
            {return}
            _leftButtonImage = leftButtonImage
            if (_leftButtonImage != nil && _leftButtonImage != "")
            {
                self.btnLeft?.isHidden = false
                let image = UIImage(named: _leftButtonImage!)
                self.btnLeft?.setImage(image, for: .normal)
                self.btnLeft?.imageView?.contentMode = .center
            }
            else{
                self.btnLeft?.isHidden = true
            }
        }
    }
    private var _rightButtonImage : String? = nil
    private var _rightSecondaryButtonImage : String? = nil
    var rightButtonImage : String? {
               didSet {
                if (rightButtonImage != nil && (rightButtonImage  == _rightButtonImage))
                {
                    return
                }
                _rightButtonImage = rightButtonImage
                if (_rightButtonImage != "")
                {
                    self.btnRight?.isHidden = false
                    let image = UIImage(named: _rightButtonImage!)
                    
                    self.btnRight?.setImage(image, for: .normal)
                    self.btnRight?.imageView?.contentMode = .center
                }
                else{
                    self.btnRight?.isHidden = true
                }
        }
    }
    var rightSecondaryButtonImage : String? {
               didSet {
                if (rightSecondaryButtonImage != nil && (rightSecondaryButtonImage  == _rightSecondaryButtonImage))
                {
                    return
                }
                _rightSecondaryButtonImage = rightSecondaryButtonImage
                if (_rightSecondaryButtonImage != "")
                {
                    self.btnRightSecondary?.isHidden = false
                    let image = UIImage(named: _rightSecondaryButtonImage!)
                    
                    self.btnRightSecondary?.setImage(image, for: .normal)
                    self.btnRightSecondary?.imageView?.contentMode = .center
                }
                else{
                    self.btnRightSecondary?.isHidden = true
                }
        }
    }
    private var _heading : String? = nil
    var heading : String?{
        didSet {
            
            _heading = heading;
            if(_heading != nil){
                
            self.lblHeading?.isHidden = false
                self.lblHeading?.text = _heading!
            }
        }
    }
    var _bgImage : String?{
        didSet {
            let hImage : UIImage! = UIImage(named: _bgImage!)
            imgHeading?.isHidden = false
            imgHeading?.image = hImage
            self.lblHeading?.isHidden = true
        }
        
    }
    private var _bgColorVar : String?
    var bgColorVar : String?{
        didSet {
            
            if bgColorVar != "" {
                if bgColorVar == "cc"{
                    self.viewContainer?.backgroundColor = .clear
                }
                else{
                self.viewContainer?.backgroundColor = Utilities.hexStringToUIColor(hex: bgColorVar!)//UIColor(hexString: bgColorVar!)
                }

            }
            self.backgroundColor = UIColor.clear
        }
    }
    var _isBackgroundColored : Bool?
    var view:UIView!;

    override public func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
//        if (Device.IS_IPHONE_XS_MAX || Device.IS_IPHONE_X){
//            self.bottomConstraintHeading?.constant = 50
//
//        }
      }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    @objc func textfieldValueChanged(sender: BaseUITextfield){
//        //print(sender.text)
        let value = sender.text ?? ""
        delegate?.headedrViewSearchTextChanged?(str: value)
    }
    @IBAction func leftbuttonClicked(sender: UIButton!) -> Void {
         delegate?.headerViewLeftBtnDidClick?(headerView: self)
    }
    @IBAction func rightSeconaryButtonClicked(sender: UIButton!) -> Void {
          delegate?.headerViewRightSecondaryBtnDidClick?(headerView: self)
    }
    @IBAction func rightbuttonClicked(sender: UIButton!) -> Void {
          delegate?.headerViewRightBtnDidClick?(headerView: self)
    }
    public func updateHeaderWithHeadingText(hText: String, rightBtnImageName: String, leftBtnImageName: String, backgroundImageName: String  ) -> Void {
    }
    
    public func updateHeaderWithHeadingText(hText: String, rightBtnImageName: String, leftBtnImageName: String, backgroundImageName: String, bgColor: String  ) -> Void {
        
         rightButtonImage  = rightBtnImageName
         leftButtonImage    = leftBtnImageName
         bgColorVar = bgColor
         heading = hText
        _bgImage  = backgroundImageName;
        
        
    }
}
