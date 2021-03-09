//
//  ConfirmPasswordViewModel.swift
//  Pulse
//
//  Created by Hamza Khan on 08/11/2020.
//

import UIKit
import SimpleTwoWayBinding


class ConfirmPasswordViewModel{
    let headerTitle = ""
    private var navBarType : navigationBarTypes!
    var password : Observable<String> = Observable()
    var confirmPassword : Observable<String> = Observable()
    private var email : String!
    var resetCode : String!
    var repository : ConfirmPasswordRepository!
    init(navigationType navBar : navigationBarTypes,  injectRepo repository : ConfirmPasswordRepository, email : String, otp : String) {
        self.navBarType = navBar
        self.email = email
        self.resetCode = otp
        self.repository = repository
    }
    func getNavigationBar()-> navigationBarTypes{
        return navBarType
    }
    func validate() throws -> Bool{
        if password.value != confirmPassword.value{
            throw PasswordErrors.invalidPassword
        }
        else if resetCode == nil { throw textFieldValidationErrors.emptyValue}
        else if !Utilities.isValidPassword(password: password.value ?? "") { throw PasswordErrors.invalidPassword}
        return true
    }
    func changePassword(completionHandler: @escaping(_ isSuccess : Bool , _ serverMsg : String)->Void){
        do{
            if try self.validate(){
                self.repository.changeOldPassword(resetCode : resetCode, email: self.email, password: password.value ?? "") { (success, serverMessage) in
                    completionHandler(success, serverMessage)
                }
            }
        }
        catch textFieldValidationErrors.invalidValue {
            completionHandler(false, ErrorDescription.emptyData.rawValue)
        }
        catch textFieldValidationErrors.emptyValue {
            completionHandler(false, ErrorDescription.emptyData.rawValue)
        }
        catch PasswordErrors.invalidPassword{
            completionHandler(false, ErrorDescription.invalidPasswordd.rawValue)
        }
        catch{
            completionHandler(false, ErrorDescription.invalidPasswordd.rawValue)
        }
    }
}

