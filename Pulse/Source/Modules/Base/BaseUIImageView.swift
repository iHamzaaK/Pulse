//
//  BaseUIImageView.swift
//  Halal
//
//  Created by Hamza Khan on 15/11/2019.
//  Copyright © 2019 Hamza. All rights reserved.
//

import UIKit

class BaseUIImageView : UIImageView{
    @IBInspectable var isRounded : Bool = false {
        didSet{
            self.roundedCorners()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.roundedCorners()
    }
    private func roundedCorners(){
        if self.isRounded{
            self.layer.cornerRadius = self.frame.height/2
        }
    }
}
