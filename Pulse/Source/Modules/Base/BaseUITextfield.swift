//
//  BaseUITextfield.swift
//  Halal
//
//  Created by Hamza Khan on 21/10/2019.
//  Copyright © 2019 Hamza. All rights reserved.
//

import UIKit

class BaseUITextfield : UITextField{
  @IBInspectable var rightPadding: CGFloat = 0
  @IBInspectable var nibFontForIPhone : CGFloat = 0.0
  @IBInspectable var nibFontForIPad : CGFloat = 0.0
  @IBInspectable var leftPadding: CGFloat = 0
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
  @IBInspectable var color: UIColor = UIColor.lightGray {
    didSet {
      updateView()
    }
  }

  override func awakeFromNib() {
    if let placeHolderText = self.placeholder{
      self.placeholder = placeHolderText
    }
    var fontSize = self.font!.pointSize

    if nibFontForIPad != 0.0 && DesignUtility.isIPad{
      fontSize = nibFontForIPad
    }
    else if nibFontForIPhone != 0.0 && !DesignUtility.isIPad{
      fontSize = nibFontForIPhone
    }
    let modifiedFontSize = DesignUtility.getFontSize(fSize: fontSize)
    let fontName = "Montserrat-Regular"
    let font = UIFont.init(name: fontName , size: modifiedFontSize)
    self.font = font

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
