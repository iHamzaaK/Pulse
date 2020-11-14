//
//  Enum.swift
//  Halal
//
//  Created by hamza Ahmed on 16.10.19.
//  Copyright © 2019 Hamza. All rights reserved.
//

import UIKit

enum Storyboards : String{
    case auth = "Authentication"
    case signup = "Signup"
    case dashboard = "Dashboard"
    case forgetPassword = "ForgetPassword"
    case confirmPassword = "ConfirmPassword"
    case rightMenu = "RightMenu"
    case settings = "Settings"
    case fullArticle = "FullArticle"
    case splash = "Splash"
    case aboutus = "AboutUs"




}

enum ViewControllersIdentifier: String{
    case interest = "InterestViewController"
    case bookmark = "BookmarksViewController"
    case categories = "CategoriesViewController"
    case fullArticle = "FullArticleViewController"
    case aboutus = "AboutUsViewController"
    case splash = "SplashViewController"
    case login = "LoginViewController"
    case dashboard = "DashboardViewController"
    case forgetPassword = "ForgetPasswordViewController"
    case confirmPassword = "ConfirmPasswordViewController"
    case rightMenu = "RightMenuViewController"
    case settings = "SettingsViewController"
}
enum LocalizeFiles : String{
    case button = "Button"
    case label = "Label"
    case txtFields = "TextFields"
    case text = "Text"
    case navigationTitle = "NavigationTitle"
}
enum Gender : Int{
    case female = 0
    case male
}

enum CellTypes{
    case dropDown
    case textField
    case button
    case facebook
    case label
    case register
    case timeSlots
    case dashboard
    case datePicker
    case categories
    case location
    case restaurantFinder

    func signupTextField()-> String { return signupCellIdentifier}
    func signupFacebookField()-> String { return facebookCellIdentifier}
    func signupLabel()-> String { return labelCellIdentifier }
    func signupRegisteration()-> String{ return signupRegisterationCellIdentifier }
    func signupTimeSlots()-> String{ return signupTimeSlotCellIdentifier }
    func dashboardCell()-> String{ return dashboardCellIdentifier }
    func restaurantFinder()-> String{ return dashboardCellIdentifier }

    
}
enum KeyboardTypes{
    case email
    case normal
    case phonePad
}
enum StatusCode : Int{
    case success = 1000
    case authExpired = 1001
    case error = 1002
}
enum ErrorDescription : String {
    case errorTitle = "Error"
    case invalidEmail = "Invalid Email"
    case invalidPasswordd = "Invalid Password. Password must be of atleast 6 characters including an uppercase, lowercase and number"
    case passwordMismatch = "Password and confirm password doesn't match."
    case invalidData = "Input not correct"
    case invalidDate = "Time To should be greater then time from"

    case emptyData = "Field cannot be empty"
    case unknown = "Something went wrong. Please try again. Thank you!"
    
}

enum userTypes : String{
    case customer = "Customer"
    case restaurant = "Restaurant"
}
enum userStatus : String{
    case active = "Active"
    case notVerify = "Not_Verify"
    case suspend = "Suspended"
}

enum EmailErrors: Error {
    case invalidEmail
}
enum PasswordErrors: Error {
    case invalidPassword
    case passwordMismatch
}
enum textFieldValidationErrors : Error {
    case emptyValue
    case invalidValue
    case timeInvalid
}

enum webserviceError : Error{
    case dataNotSerialized
}
enum appColors {
    case green
    case adBlue
    case headerBlue
    case grayBorderColor
    
    var colorStatus : UIColor{
        get{
            switch self {
            case .green:
                return Utilities.hexStringToUIColor(hex: "44ad47")
            case .adBlue:
                return Utilities.hexStringToUIColor(hex: "005b72")
            case .headerBlue:
                return Utilities.hexStringToUIColor(hex: "5b92fa")
            case .grayBorderColor:
                return Utilities.hexStringToUIColor(hex: "e3e3e3")

            }
        }
    }
}
enum ImagesTextField : String{
    case email = "email"
    case password = "password"
    case name = "name"
    case website = "worldwide"
    case phone = "phone"
    case firmName = "home"
}
