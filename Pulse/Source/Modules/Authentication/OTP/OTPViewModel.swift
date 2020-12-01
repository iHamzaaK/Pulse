//
//  OTPViewModel.swift
//  Pulse
//
//  Created by Hamza Khan on 01/12/2020.
//

import Foundation
import UIKit

class OTPViewModel
{
    let headerTitle = ""
    private let navBarType : navigationBarTypes!
    let repository : OTPRepository!
    let userEmail : String!
    var otp : String = ""
    let forgetPassRepository : ForgetPasswordRepositoryProtocol!
    
    init(navigationType navBar : navigationBarTypes, repo : OTPRepository, email: String, forgetPassRepo: ForgetPasswordRepositoryProtocol) {
        self.navBarType = navBar
        self.repository = repo
        self.userEmail = email
        self.forgetPassRepository = forgetPassRepo
    }
    func getNavigationBar()-> navigationBarTypes{
        return navBarType
    }
    func validateOTP() throws -> Bool{
       if otp == "" { throw textFieldValidationErrors.emptyValue}
       return true
    }
    
    func otpProcess(completionHandler : @escaping (_ isSuccess : Bool , _ serverMsg : String)->Void){
       do{
          if try self.validateOTP(){
            self.repository.sendOTP(otp: otp, email: userEmail) { (success, serverMsg) in
                completionHandler(success,serverMsg)
            }
          }
       }
       catch textFieldValidationErrors.emptyValue{
          completionHandler(false, ErrorDescription.emptyData.rawValue)
       }
       catch{
       }
    }
    
    func resetPassword(completionHandler : @escaping (_ isSuccess : Bool , _ serverMsg : String)->Void){
      
        self.forgetPassRepository.resetPassword(email: self.userEmail) { (success, serverMsg) in
                completionHandler(success, serverMsg)
        }
      
    }
}
