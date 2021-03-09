//
//  FooterView.swift
//  SwiftBaseProject
//
//  Created by Syed Sharjeel Ali on 3/22/17.
//  Copyright © 2017 Syed Sharjeel Ali. All rights reserved.
//

import UIKit
@objc protocol FooterViewDelegate {
    @objc optional func footerViewRightButtonDidTap(footerView : FooterView) -> Void
    @objc optional func footerViewLeftButtonDidTap(footerView : FooterView) -> Void
}

class FooterView: UIView {
    var delegate: FooterViewDelegate?
    @IBOutlet weak var btnLeftFooter: UIButton?
    @IBOutlet weak var btnRightFooter: UIButton?
    @IBOutlet weak var lblFooterTitle: UILabel?
    @IBOutlet var viewContainer: UIView?
    var bgColorHeighlightedFooter : String?
    private var _leftButtonImage : String? = nil
    var leftButtonImage : String?{
        didSet
        {
            if (leftButtonImage != nil && (leftButtonImage  == _leftButtonImage))
            {return}
            _leftButtonImage = leftButtonImage

            if (_leftButtonImage != nil && _leftButtonImage != "")
            {
                self.btnLeftFooter?.isHidden = false
                let image = UIImage(named: _leftButtonImage!)
                
                self.btnLeftFooter?.setImage(image, for: .normal)
//                self.btnLeftFooter?.setImage(UIImage (setImageForPro:  _leftButtonImage!), for: .normal)
            }
            else{
                self.btnLeftFooter?.isHidden = true
            }
        }
    }
    
    private var _rightButtonImage : String? = nil
    
    var rightButtonImage : String? {
        didSet {
            
            if (rightButtonImage != nil && (rightButtonImage  == _rightButtonImage))
            {
                return
            }
            _rightButtonImage = rightButtonImage
            if (_rightButtonImage != "")
            {
                self.btnRightFooter?.isHidden = false
                let image = UIImage(named: _rightButtonImage!)
                
                self.btnRightFooter?.setImage(image, for: .normal)
                
            }
            else{
                self.btnRightFooter?.isHidden = true
            }
        }
    }
    
    
    
    private var _bgColorVar : String?
    var bgColorVar : String?{
        didSet {
            _bgColorVar = bgColorVar
            if ((bgColorVar) != nil)
            {
                self.viewContainer?.backgroundColor = Utilities.hexStringToUIColor(hex: bgColorVar!)//UIColor(hexString: bgColorVar!)
                
            }
        }
    }
    
    var _isBackgroundColored : Bool?
    
    @IBAction func fbButtonTapped(sender: UIButton!) -> Void {
        delegate?.footerViewRightButtonDidTap?(footerView: self)
    }
    @IBAction func twitterButtonTapped(sender: UIButton!) -> Void {
        delegate?.footerViewLeftButtonDidTap?(footerView: self)
    }
    
    public func updateFooterWithHeadingText(hText: String, rightBtnImageName: String, leftBtnImageName: String, backgroundImageName: String  ) -> Void {
    }
    
    public func updateFooterWithHeadingText(hText: String, rightBtnImageName: String, leftBtnImageName: String, bgColor: String  ) -> Void {
        
        rightButtonImage  = rightBtnImageName
        leftButtonImage    = leftBtnImageName
        bgColorVar = bgColor
        lblFooterTitle?.text = hText
        
    }
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
