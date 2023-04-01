//
//  PolicyViewModel.swift
//  Pulse
//
//  Created by Hamza Khan on 17/12/2020.
//

import Foundation

class PolicyViewModel {
  let headerTitle: String
  private let navBarType : navigationBarTypes!
  let repo : PolicyRepository
  let endPoint : String

  init(navigationType navBar : navigationBarTypes, repo : PolicyRepository, title : String, endPoint : String) {
    self.navBarType = navBar
    self.repo = repo
    self.headerTitle = title
    self.endPoint = endPoint
  }

  func getTitle()->String{
    return headerTitle
  }

  func getNavigationBar()-> navigationBarTypes{
    return navBarType
  }

  func getDescription(content: String)-> NSAttributedString?{
    var fontSize = 15
    fontSize = Int(DesignUtility.convertToRatio(CGFloat(fontSize), sizedForIPad: DesignUtility.isIPad, sizedForNavi: false))
    let attirbutedString = Utilities.getAttributedStringForHTMLWithFont(content, textSize: fontSize, fontName: "Montserrat-Regular")
    return attirbutedString
  }

  func getPolicy(completionHandler: @escaping ( _ success : Bool , _ serverMsg : String, _ policyContent  : NSAttributedString?)->Void){
    self.repo.getPolicy(endpoint: self.endPoint, completionHandler: { (success, serverMsg, content)  in
      completionHandler(success, serverMsg, self.getDescription(content: content))
    })
  }
}
