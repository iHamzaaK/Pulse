//
//  BaseUIView.swift
//  Pulse
//
//  Created by Hamza Khan on 08/11/2020.
//

import UIKit

class BaseUIView: UIView {
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

  override func awakeFromNib() {
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    self.roundedCorners()
  }

  private func roundedCorners(){
    if self.isRoundRect{
      self.cornerRadius = 0.0
      self.layer.cornerRadius = self.frame.height/2
    }
  }
}
