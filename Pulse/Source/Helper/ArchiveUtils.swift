//
//  ArchiveUtils.swift
//  Halal
//
//  Created by Hamza Khan on 13/11/2019.
//  Copyright © 2019 Hamza. All rights reserved.
//

import Foundation
class ArchiveUtil {
    
    private static let userDataKey = "userData"
    private static let restaurantDataKey = "restaurantData"
    private static let categoryDataKey = "categoryData"
    private static let userTypeKey = "userType"
    private static let userLocationLat = "userTypeLatitude"
    private static let userLocationLong = "userTypeLongitude"
    private static let userLanguage = "userLanguage"
    private static let restaurantType = "restaurantType"
    private static let signupStep = "signupStep"

    
    /*
    static func loadUser()-> User?{
        guard let user = UserDefaults.standard.data(forKey: userDataKey) else { return nil}
        do{
            let userData = try JSONDecoder().decode(User.self, from: user)
            return userData
        }
        catch{
            return nil
        }
    }
    static func deleteSession(){
        UserDefaults.standard.removeObject(forKey: userDataKey)
        UserDefaults.standard.removeObject(forKey: restaurantDataKey)
        UserDefaults.standard.removeObject(forKey: userTypeKey)
    }
    
    static func saveSession(session: String){
        
    }
    
    static func checkSignupStep()->Int{
        let step = UserDefaults.standard.integer(forKey: signupStep)
        return step
    }
    static func saveSignupStep(step: Int){
         UserDefaults.standard.set(step, forKey: signupStep)
        
    }
    
    static func saveUser(userData: User){
        do{
            let user = try JSONEncoder().encode(userData)
            UserDefaults.standard.set(user, forKey: userDataKey)
        }
        catch{
            //print("Not working")
        }
    }
    static func loadRestaurant()-> RestaurantOwner?{
        guard let user = UserDefaults.standard.data(forKey: restaurantDataKey) else { return nil}
        do{
            let userData = try JSONDecoder().decode(RestaurantOwner.self, from: user)
            return userData
        }
        catch{
            return nil
        }
    }
    static func saveRestaurant(userData: RestaurantOwner){
        do{
            let user = try JSONEncoder().encode(userData)
            UserDefaults.standard.set(user, forKey: restaurantDataKey)
        }
        catch{
            
        }
    }
    static func saveRestaurantType(types : [RestaurantType]){
        do{
            let restaurant = try JSONEncoder().encode(types)
            UserDefaults.standard.set(restaurant, forKey: restaurantType)
        }
        catch{
            
        }
    }
    static func loadRestaurantType()->[RestaurantType]{
        guard let restaurant = UserDefaults.standard.data(forKey: restaurantType) else { return []}
        do{
            let restaurantData = try JSONDecoder().decode([RestaurantType].self, from: restaurant)
            return restaurantData
        }
        catch{
            return []
        }
    }
    static func loadCategories()-> [CategoriesData]{
        guard let cat = UserDefaults.standard.data(forKey: categoryDataKey) else { return []}
        do{
        let catData = try JSONDecoder().decode([CategoriesData].self, from: cat)
        return catData
        }
        catch{
            return []
        }
    }
    static func saveCategories(categories: [CategoriesData]){
        do{
            let catData = try JSONEncoder().encode(categories)
            UserDefaults.standard.set(catData, forKey: categoryDataKey)
        }
        catch{
            
        }
    }
    static func getRestaurantId()->Int{
        guard let user = UserDefaults.standard.data(forKey: restaurantDataKey) else { return -1}
        do{
            let userData = try JSONDecoder().decode(RestaurantOwner.self, from: user)
            return userData.id
        }
        catch{
            return -1
        }
    }
    static func getRestaurantToken()->String{
        guard let user = UserDefaults.standard.data(forKey: restaurantDataKey) else { return ""}
        do{
            let userData = try JSONDecoder().decode(RestaurantOwner.self, from: user)
            return userData.accessToken
        }
        catch{
            return ""
        }
    }
    static func getUserToken()->String{
        guard let user = UserDefaults.standard.data(forKey: userDataKey) else { return ""}
        do{
            let userData = try JSONDecoder().decode(User.self, from: user)
            return userData.accessToken
        }
        catch{
            return ""
        }
    }
    static func saveUserType(userType : String){
        UserDefaults.standard.set(userType, forKey: userTypeKey)
    }
    static func getUserType()-> userTypes?{
        if let userType = UserDefaults.standard.object(forKey: userTypeKey) as? String{
            if userType == userTypes.customer.rawValue{
                return userTypes.customer
            }
            return userTypes.restaurant
        }
        return nil
    }
    static func saveUserLocation(userLat : Double, userLong : Double){
        UserDefaults.standard.set(userLat, forKey: userLocationLat)
        UserDefaults.standard.set(userLong, forKey: userLocationLong)
        
    }
    static func getUserLocation()-> (Double , Double){
        let lat = UserDefaults.standard.double(forKey: userLocationLat)
        let long = UserDefaults.standard.double(forKey: userLocationLong)
        return (lat,long)
    }
    static func saveUserLangugae(langugae: String){
        UserDefaults.standard.set(langugae, forKey: userLanguage)
    }
    static func getUserLanguage()->String{
        return UserDefaults.standard.string(forKey: userLanguage) ?? "en"
    }
 */
}

