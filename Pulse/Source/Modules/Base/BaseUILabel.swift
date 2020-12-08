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
    @IBInspectable var fontName : String = ""
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
        if fontName == ""{
            fontName = "Montserrat-Regular"
        }
        let font = UIFont.init(name: fontName , size: modifiedFontSize)
        self.font = font
    }
//    == Montserrat-Regular
//    == Montserrat-Light
//    == Montserrat-Medium
//    == Montserrat-SemiBold
//
    func changeLanguage(){
        if let txt = self.text{
                   self.text = txt
        }
    }
}
