//
//  Utilities.swift
//  Halal
//
//  Created by hamza Ahmed on 16.10.19.
//  Copyright © 2019 Hamza. All rights reserved.
//

import UIKit

class Utilities{
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    static func getStoryboard(identifier: String)-> UIStoryboard{
        return UIStoryboard(name: identifier, bundle: Bundle.main)
    }
    static func registerNib(nibName : String, identifier : String, tblView : UITableView){
        let nib = UINib(nibName: nibName, bundle: Bundle.main)
        tblView.register(nib, forCellReuseIdentifier: identifier)
    }
    static func registerNibForCollectionView(nibName : String, identifier : String, colView : UICollectionView){
        let nib = UINib(nibName: nibName, bundle: Bundle.main)
        colView.register(nib, forCellWithReuseIdentifier: identifier)
    }
    static func registerHeaderNibForCollectionView(nibName : String, identifier : String, colView : UICollectionView){
        let nib = UINib(nibName: nibName, bundle: Bundle.main)
        colView.register(nib, forSupplementaryViewOfKind: nibName, withReuseIdentifier: identifier)
    }
   static func getGenderList()->[String:String]{
      return ["0":"Female","1":"Male"]
    }
    static func addViewControllerAsChildViewController(_ childVC : UIViewController, parentVC : UIViewController, yConstraint: CGFloat,heightConstraint: CGFloat){
        parentVC.addChild(childVC)
        
        parentVC.view.addSubview(childVC.view)
        childVC.view.frame = CGRect(x: parentVC.view.bounds.origin.x, y: yConstraint, width: parentVC.view.bounds.width, height: heightConstraint)
        childVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childVC.didMove(toParent: parentVC)
    }
    static func getAgeFromDOB(date: String) -> (Int,Int,Int) {

        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "YYYY-MM-dd"
        let dateOfBirth = dateFormater.date(from: date)

        let calender = Calendar.current

        let dateComponent = calender.dateComponents([.year, .month, .day], from:
        dateOfBirth!, to: Date())

        return (dateComponent.year!, dateComponent.month!, dateComponent.day!)
    }
    static func isValidEmail(email:String?) -> Bool {
        
        guard email != nil else { return false }
        
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
    static func isValidPassword(password:String?) -> Bool {
        guard password != nil else { return false }
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        if password == ""{
            return false
        }
        return true
//        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{6,}")
//        return passwordTest.evaluate(with: password)
    }
    static func getHeaderHeight()->CGFloat{
        if (Device.IS_IPHONE_4_OR_LESS){
            return 60
        }
        else if(Device.IS_IPHONE_5){
            return 60
        }
        else if(Device.IS_IPHONE_6){
            return 65
        }
        else if(Device.IS_IPHONE_6P){
            return 70
        }
        else if (Device.IS_IPHONE_XS_MAX){
            return 90
        }
        else if (Device.IS_IPHONE_X){
            return 85
        }
        else{
            return 75
        }
    }
}
import Kingfisher
struct ImageProgressIndicator: Indicator {
    let view: UIView = UIView()
    
    func startAnimatingView() { view.isHidden = false }
    func stopAnimatingView() { view.isHidden = true }
    
    init() {
        view.backgroundColor = .clear
    }
}


