//
//  Utilities.swift
//  Halal
//
//  Created by hamza Ahmed on 16.10.19.
//  Copyright © 2019 Hamza. All rights reserved.
//

import UIKit
import Kingfisher
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
        let storyboardName = identifier + "-" + self.getStoryboardTypeForDeviceType()

        return UIStoryboard(name: storyboardName, bundle: Bundle.main)
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
        else if (Device.IS_IPHONE_12_PRO){
            return 90
        }
        else if (Device.IS_IPHONE_12_MAX){
            return 95
        }
        else if (Device.IS_IPHONE_X){
            return 90
        }
        else{
            return 100
        }
    }
    static func addBlur(view: UIView, blurEffect: UIBlurEffect.Style){
        view.backgroundColor = UIColor.clear
        
        //                 Create a blur effect
        let blurEffect = UIBlurEffect(style: blurEffect)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        // Fill the view
        blurEffectView.frame = view.bounds
        
        // Ensure the blur conforms to resizing (not used in a fixed menu UI)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Add the view to the view controller stack
        view.addSubview(blurEffectView)
        
        //                 Ensure the blur view is in the back
        view.sendSubviewToBack(blurEffectView)
    }
    
    static func getDeviceTypeStr() -> String {
        if DesignUtility.isIPad{
            return "iPad"
        }
        else{
            return "iPhone"
        }
    }
    
    static func getImageFromURL(imgView: UIImageView, url: URL, completion: @escaping( _ result : Result<RetrieveImageResult, KingfisherError>)->Void){
        imgView.kf.indicatorType = .activity
        imgView.kf.setImage(with: url, placeholder: UIImage.init(named: "placeholder")!, options: [.transition(.fade(0.1)),.cacheOriginalImage], completionHandler: { result in
            completion(result)
        })

    }
    
    static func getStoryboardTypeForDeviceType()->String{
        let storyboardType = self.getDeviceTypeStr()
        
        return storyboardType
        
    }
    static func getImage(str: String)->UIImage?{
        return UIImage.init(named: str)
    }
    static func getAttributedStringForHTMLWithFont(_ htmlStr : String , textSize : Int , fontName : String )->NSAttributedString?
    {
        var htmlStr = htmlStr
        do {
            if htmlStr .isEmpty{
                htmlStr = "<p></p>"
            }
            let str = "<div style=\"color:#5A5A5A; font-size: \(textSize)px\"><font face=\"\(fontName)\">\(htmlStr)</font></div>"
            let data : Data = str .data(using: String.Encoding.unicode)!
            let attributedOptions : [String: Any] = [
                convertFromNSAttributedStringDocumentAttributeKey(NSAttributedString.DocumentAttributeKey.documentType) : convertFromNSAttributedStringDocumentType(NSAttributedString.DocumentType.html),
                convertFromNSAttributedStringDocumentAttributeKey(NSAttributedString.DocumentAttributeKey.characterEncoding): String.Encoding.utf8.rawValue
            ]
            do {
                 let attributedStr = try NSAttributedString.init(data: data, options: convertToNSAttributedStringDocumentReadingOptionKeyDictionary(attributedOptions), documentAttributes: nil)
                return attributedStr
            } catch {
                print( error )
            }
            return nil
        }
        catch {
            return nil
        }
    }
    static func convertFromNSAttributedStringDocumentAttributeKey(_ input: NSAttributedString.DocumentAttributeKey) -> String {
        return input.rawValue
    }

    // Helper function inserted by Swift 4.2 migrator.
    static func convertFromNSAttributedStringDocumentType(_ input: NSAttributedString.DocumentType) -> String {
        return input.rawValue
    }

    // Helper function inserted by Swift 4.2 migrator.
    static  func convertToNSAttributedStringDocumentReadingOptionKeyDictionary(_ input: [String: Any]) -> [NSAttributedString.DocumentReadingOptionKey: Any] {
        return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.DocumentReadingOptionKey(rawValue: key), value)})
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


