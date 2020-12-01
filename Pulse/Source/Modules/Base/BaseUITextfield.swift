//
//  BaseUITextfield.swift
//  Halal
//
//  Created by Hamza Khan on 21/10/2019.
//  Copyright © 2019 Hamza. All rights reserved.
//

import UIKit

class BaseUITextfield : UITextField{
    @IBInspectable var isRoundRect : Bool = false{
        didSet{
            roundRectTextfieldShape()
        }
    }
    @IBInspectable
       var cornerRadius: CGFloat = 0.0 {
            didSet{
                self.layer.cornerRadius = cornerRadius
            }
        }
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateView()
        }
    }
    @IBInspectable var rightPadding: CGFloat = 0
    
    @IBInspectable var leftPadding: CGFloat = 0
    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    override func awakeFromNib() {
        
        if let placeHolderText = self.placeholder{
            self.placeholder = placeHolderText
        }
        
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    private func updateView() {
        
        if let image = leftImage ,  leftImage != nil{
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 10, width: 20, height: 20))
            imageView.contentMode = .center
            imageView.image = image
            imageView.tintColor = color
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
            view.addSubview(imageView)
            view.backgroundColor = .clear
            leftView = view
        } else {
            leftViewMode = UITextField.ViewMode.always
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
            view.backgroundColor = .clear
            leftView = view
        }
        if let rightImg = rightImage, rightImage != nil{
            rightViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 10, width: 20, height: 20))
            imageView.contentMode = .center
            imageView.image = rightImg
            imageView.tintColor = color
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
            view.addSubview(imageView)
            view.backgroundColor = .clear
            rightView = view
        } else {
            rightViewMode = UITextField.ViewMode.always
//            let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
//            view.backgroundColor = .clear
//            rightView = view
        }
        
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }
    private func roundRectTextfieldShape(){
        if self.isRoundRect{
            self.layer.cornerRadius = self.frame.height/2
            self.layer.borderWidth = 1.0
            self.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
}
