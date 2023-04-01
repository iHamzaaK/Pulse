//
//  FilterHeader.swift
//  Pulse
//
//  Created by Hamza Khan on 07.03.22.
//

import UIKit

final class FilterHeader: UICollectionReusableView {

  @IBOutlet var lblTitle : UILabel!
  @IBOutlet var view : UIView!

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

  }
    
}
