//
//  Alert.swift
//  Halal
//
//  Created by Hamza Khan on 02/11/2019.
//  Copyright © 2019 Hamza. All rights reserved.
//

import UIKit
import CDAlertView
class Alert{
    static func showAlertWithAutoHide(title :String , message : String , autoHidetimer : Double, type : CDAlertViewType){
        let alert = CDAlertView(title: title, message: message, type: type)
        alert.autoHideTime = autoHidetimer
        alert.hasRoundCorners = true
        alert.show()
    }
    static func showAlertWithButtons(title :String , message : String , autoHidetimer : Double, type : CDAlertViewType, buttonTitle: String , buttonActon : @escaping ((CDAlertViewAction) -> Bool)){
        let alert = CDAlertView(title: title, message: message, type: type)
        alert.autoHideTime = autoHidetimer
        alert.hasRoundCorners = true
        let doneAction = CDAlertViewAction(title: buttonTitle, font: nil, textColor: nil, backgroundColor: nil, handler: buttonActon)
        alert.add(action: doneAction)
        alert.show()
    }
    static func showAlertWithTwoButtons(title :String , message : String , autoHidetimer : Double, type : CDAlertViewType, buttonTitleOne: String , buttonActionOne : @escaping ((CDAlertViewAction) -> Bool), buttonTitleTwo :String , buttonActionTwo : @escaping ((CDAlertViewAction) -> Bool)){
        let alert = CDAlertView(title: title, message: message, type: type)
        alert.hasRoundCorners = true
        let buttonOne = CDAlertViewAction(title: buttonTitleOne, font: nil, textColor: nil, backgroundColor: nil, handler: buttonActionOne)
        let buttonTwo = CDAlertViewAction(title: buttonTitleTwo, font: nil, textColor: nil, backgroundColor: nil, handler: buttonActionTwo)
        alert.add(action: buttonOne)
        alert.add(action: buttonTwo)

        alert.show()
    }
   
}
