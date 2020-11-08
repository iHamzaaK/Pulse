//
//  UIDeviceExtension.swift
//  Halal
//
//  Created by Hamza Khan on 01/11/2019.
//  Copyright © 2019 Hamza. All rights reserved.
//

import UIKit

struct Device {
    // iDevice detection code
    static let IS_IPAD             = UIDevice.current.userInterfaceIdiom == .pad
    static let IS_IPHONE           = UIDevice.current.userInterfaceIdiom == .phone
    static let IS_RETINA           = UIScreen.main.scale >= 2.0
    
    static let SCREEN_WIDTH        = Int(UIScreen.main.bounds.size.width)
    static let SCREEN_HEIGHT       = Int(UIScreen.main.bounds.size.height)
    static let SCREEN_MAX_LENGTH   = Int( max(SCREEN_WIDTH, SCREEN_HEIGHT) )
    static let SCREEN_MIN_LENGTH   = Int( min(SCREEN_WIDTH, SCREEN_HEIGHT) )
    
    static let IS_IPHONE_4_OR_LESS = IS_IPHONE && SCREEN_MAX_LENGTH  < 568
    static let IS_IPHONE_5         = IS_IPHONE && SCREEN_MAX_LENGTH == 568
    static let IS_IPHONE_6         = IS_IPHONE && SCREEN_MAX_LENGTH == 667 // 8, SE
    static let IS_IPHONE_6P        = IS_IPHONE && SCREEN_MAX_LENGTH == 736
     static let IS_IPHONE_X            = IS_IPHONE && SCREEN_MAX_LENGTH == 812 // X, XS, 12 Mini
    static let IS_IPHONE_12_MAX         = IS_IPHONE && SCREEN_MAX_LENGTH == 926 // XR, XS Max, 11, 11 Pro Max
    static let IS_IPHONE_12_PRO         = IS_IPHONE && SCREEN_MAX_LENGTH == 844 // 12 and Pro


}



