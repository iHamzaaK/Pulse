//
//  BaseUILabel.swift
//  Halal
//
//  Created by Hamza Khan on 09/01/2020.
//  Copyright © 2020 Hamza. All rights reserved.
//

import UIKit

class BaseUILabel: UILabel {
    
    override func awakeFromNib() {
//       changeLanguage()
    }
    func changeLanguage(){
        if let txt = self.text{
                   self.text = txt
        }
    }
}
