//
//  ForgetPassword.swift
//  Pulse
//
//  Created by Hamza Khan on 07/11/2020.
//

import Foundation
import SimpleTwoWayBinding

final class ForgetPasswordViewModel{
  private let headerTitle = "Forget Password"
  private let navBarType : navigationBarTypes!
  private var repository : ForgetPasswordRepositoryProtocol!
  var email : Observable<String> = Observable()

  init(navigationType navBar : navigationBarTypes, repo : ForgetPasswordRepositoryProtocol) {
    self.navBarType = navBar
    self.repository = repo
  }

  func getNavigationBar()-> navigationBarTypes{
    return navBarType
  }

  func validateEmail() throws -> Bool{
    if !Utilities.isValidEmail(email: email.value ?? "") { throw EmailErrors.invalidEmail}
    return true
  }

  func resetPassword(completionHandler : @escaping (_ isSuccess : Bool , _ serverMsg : String)->Void){
    do{
      if try self.validateEmail(){
        self.repository.resetPassword(email: self.email.value!) { (success, serverMsg) in
          completionHandler(success, serverMsg)
        }
      }
    }
    catch EmailErrors.invalidEmail{
      completionHandler(false, ErrorDescription.invalidEmail.rawValue)
    }
    catch{}
  }
}
