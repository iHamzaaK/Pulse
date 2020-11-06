//
//  BaseUIButton.swift
//  Halal
//
//  Created by Hamza Khan on 21/10/2019.
//  Copyright © 2019 Hamza. All rights reserved.
//

import UIKit
class BaseUIButton: UIButton {
    
   
    
    @IBInspectable var isRoundRect : Bool = false{
        didSet{
            
            self.roundedCorners()
        }
    }
     @IBInspectable
    var borderWidth: CGFloat = 0.0 {
         didSet{
             self.layer.borderWidth = borderWidth
         }
     }
     @IBInspectable
        var cornerRadius: CGFloat = 0.0 {
             didSet{
                 self.layer.cornerRadius = cornerRadius
             }
         }
     @IBInspectable
     var borderColor: UIColor? {
        didSet{
            self.layer.borderColor = borderColor?.cgColor
        }
     }
    
    @IBInspectable var imageSpacing : CGFloat = 0.0{
        didSet{
            self.centerTextAndImage(spacing: imageSpacing)
        }
    }
    @IBInspectable var setCustomSelectionState : Bool = false
    
    override var isSelected: Bool{
        didSet{
            if setCustomSelectionState{
                self.setImageTint()
            }
        }
    }
    override func awakeFromNib() {
        self.isSelected = false
        if let title = self.titleLabel?.text{
            self.setTitle(title, for: .normal)
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.roundedCorners()
    }
    private func setImageTint(){
        if self.isSelected{
            self.tintColor = appColors.green.colorStatus
            self.backgroundColor = .white
            self.setTitleColor(appColors.green.colorStatus, for: .selected)
        }
        else{
            self.tintColor = .white
            self.backgroundColor = appColors.green.colorStatus
            self.setTitleColor(.white, for: .normal)

        }
    }
    private func roundedCorners(){
        if self.isRoundRect{
            self.cornerRadius = 0.0
            self.layer.cornerRadius = self.frame.height/2
        }
    }
    func centerTextAndImage(spacing: CGFloat) {
        if spacing != 0.0{
        let insetAmount = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
        }
    }
 

}
