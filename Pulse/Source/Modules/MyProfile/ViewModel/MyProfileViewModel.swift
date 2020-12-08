//
//  ProfileViewModel.swift
//  Pulse
//
//  Created by Hamza Khan on 19/11/2020.
//

import Foundation
import UIKit
import SimpleTwoWayBinding

class MyProfileViewModel
{
    let headerTitle = ""
    private let navBarType : navigationBarTypes!
    private let name : String!
    let subscrpition: [String]!
    var showInterest : Bool = false
//    let userData = ArchiveUtil.getUser()
    let profileRepo : UserProfileRepository!
    let categoryRepo : CategoriesRepository!
    var categories : [CategoriesData]!
    var password : Observable<String> = Observable()
    var confirmPassword : Observable<String> = Observable()
    var hidePasswordView : Bool!
    var hideCategories : Bool!

    init(navigationType navBar : navigationBarTypes, userData : User?, catData : [CategoriesData]?, profileRepo : UserProfileRepository, categoriesRepo: CategoriesRepository) {
        self.hidePasswordView = true
        self.hideCategories = true

        self.navBarType = navBar
        if let userData = userData {
            self.name = userData.firstName + " " +  userData.lastName
            self.subscrpition = userData.subscription
        }
        else{
            self.name = ""
            self.subscrpition = []
        }
        if let cat = catData{
            self.categories = cat
        }
        else{
            self.categories = []
        }
        self.categoryRepo = categoriesRepo
        self.profileRepo = profileRepo
        
    }
    func getCategories(completionHandler: @escaping (Bool, String) -> Void){
        self.categoryRepo.getCategories { (success, serverMsg, data) in
            self.categories = data
            completionHandler(success,serverMsg)
        }
    }
    func getItemHeight(collectionWidth : CGFloat)-> CGSize{
        var width = collectionWidth/3 - 2
        var height = width
            return CGSize(width: width, height: height)
    }
    func validate() throws -> Bool{
        if password.value != confirmPassword.value{
            throw PasswordErrors.invalidPassword
        }
        else if !Utilities.isValidPassword(password: password.value ?? "") { throw PasswordErrors.invalidPassword}
        return true
    }
    func updateProfile(param : [String:String]? , avatar : Data?, completionHandler: @escaping( _ isSuccess : Bool , _ serverMsg: String)->Void){
        self.profileRepo.changeUserProfile(params: param, avatar: avatar) { (success, serverMsg) in
            completionHandler(success,serverMsg)
        }

    }
    func updateSubscription(subscriptionId : String, completionHandler: @escaping( _ isSuccess : Bool , _ serverMsg: String)->Void){
        
        let param = [
            "subscription" : ""
        ]
        self.updateProfile(param: param, avatar: nil) { (success, serverMsg) in
            completionHandler(success,serverMsg)
        }
    }
    func updatePicture(avatar: Data , completionHandler: @escaping( _ isSuccess : Bool , _ serverMsg : String)->Void){
        self.updateProfile(param: nil, avatar: avatar) { (success, serverMsg) in
            completionHandler(success,serverMsg)
        }
        
    }
    func changePassword(completionHandler: @escaping(_ isSuccess : Bool , _ serverMsg : String)->Void){
        do{
            if try self.validate(){
                let param = [
                    "password" : password.value ?? ""
                ]
                self.updateProfile(param: param, avatar: nil) { (success, serverMsg) in
                    completionHandler(success,serverMsg)
                }
            }
        }
        catch PasswordErrors.invalidPassword{
            completionHandler(false, ErrorDescription.invalidPasswordd.rawValue)
        }
        catch{
            completionHandler(false, ErrorDescription.invalidPasswordd.rawValue)
        }
    }
    func getNavigationBar()-> navigationBarTypes{
        return navBarType
    }
    func getName()->String{
        return name
    }
    func getCategoriesCount()->Int{
        return categories?.count ?? 0
    }
    func getCellViewModelForRow(row: Int)->CategoryCellViewModel{
        let category = self.categories[row]
        let cellViewModel = CategoryCellViewModel(id: category.id, name: category.name ?? "", description: category.descriptionField ?? "", parent: category.parent ?? -1, icon: category.icon ?? "", image: category.image ?? "", child: category.child ?? [], isVideo: category.isVideo ?? false, isQuote: category.isQoute ?? false)
        return cellViewModel
        
    }
    
    
    
   
}
