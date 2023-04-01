//image

//
//  BaseParallaxHeaderView.swift
//  Halal
//
//  Created by Hamza Khan on 01/02/2020.
//  Copyright © 2020 Hamza. All rights reserved.
//

import Foundation
import UIKit


class BaseParallaxHeaderView: UIView {
  var heightLayoutConstraint = NSLayoutConstraint()
  var bottomLayoutConstraint = NSLayoutConstraint()

  var containerView = UIView()
  var containerLayoutConstraint = NSLayoutConstraint()
  var imageView : UIImageView!
  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  override func awakeFromNib() {
    self.backgroundColor = UIColor.white
    containerView.translatesAutoresizingMaskIntoConstraints = false
    containerView.backgroundColor = UIColor.red
    self.addSubview(containerView)
    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[containerView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["containerView" : containerView]))
    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[containerView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["containerView" : containerView]))
    containerLayoutConstraint = NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1.0, constant: 0.0)
    self.addConstraint(containerLayoutConstraint)

    imageView = UIImageView.init()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.backgroundColor = UIColor.white
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.image = UIImage(named: "dashboard")
    containerView.addSubview(imageView)
    containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[imageView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["imageView" : imageView]))
    bottomLayoutConstraint = NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
    containerView.addConstraint(bottomLayoutConstraint)
    heightLayoutConstraint = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: containerView, attribute: .height, multiplier: 1.0, constant: 0.0)
    containerView.addConstraint(heightLayoutConstraint)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

}

extension BaseParallaxHeaderView{
  func scrollViewDidScrollHeader(scrollView: UIScrollView) {
    containerLayoutConstraint.constant = scrollView.contentInset.top;
    let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top);
    containerView.clipsToBounds = offsetY <= 0
    bottomLayoutConstraint.constant = offsetY >= 0 ? 0 : -offsetY / 2
    heightLayoutConstraint.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
  }
}
