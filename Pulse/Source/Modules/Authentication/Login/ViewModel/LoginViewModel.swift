//
//  LoginViewModel.swift
//  Pulse
//
//  Created by Hamza Khan on 07/11/2020.
//

import Foundation
import SimpleTwoWayBinding

final class LoginViewModel{
  private let headerTitle = ""
  var email : Observable<String> = Observable()
  var password : Observable<String> = Observable()
  private let loginRepository : LoginRepository
  private let navBarType : navigationBarTypes!

  init(navigationType navBar : navigationBarTypes , repository: LoginRepository) {
    self.navBarType = navBar
    self.loginRepository = repository

  }

  func getNavigationBar()-> navigationBarTypes{
    return navBarType
  }

  func validateEmailPassword() throws -> Bool{
    if !Utilities.isValidPassword(password: password.value ?? "") { throw PasswordErrors.invalidPassword}
    return true
  }

  func login(success completionHandler : @escaping (_ isSuccess: Bool, _ errorMsg : String)->Void){
    guard let email = self.email.value,
          let password = self.password.value else {
      return completionHandler(false, "Invalid credentials")
    }
    self.loginRepository.login(userName: email, password: password) { (isSuccess, errorMsg) in
      completionHandler(isSuccess,errorMsg)
    }
  }
}
