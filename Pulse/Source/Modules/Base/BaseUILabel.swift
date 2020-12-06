//
//  BaseUILabel.swift
//  Halal
//
//  Created by Hamza Khan on 09/01/2020.
//  Copyright © 2020 Hamza. All rights reserved.
//

import UIKit

class BaseUILabel: UILabel {
    
    
    @IBInspectable  var nibFontForIPhone : CGFloat = 0.0
    @IBInspectable  var nibFontForIPad : CGFloat = 0.0

    override func awakeFromNib() {
//       changeLanguage()
        var fontSize = self.font.pointSize

        if nibFontForIPad != 0.0 && DesignUtility.isIPad{
            fontSize = nibFontForIPad
        }
        else if nibFontForIPhone != 0.0 && !DesignUtility.isIPad{
            fontSize = nibFontForIPhone
        }
        let modifiedFontSize = DesignUtility.getFontSize(fSize: fontSize)
        
        let font = UIFont.systemFont(ofSize: modifiedFontSize)
        self.font = font
    }
    
    
    func changeLanguage(){
        if let txt = self.text{
                   self.text = txt
        }
    }
}
