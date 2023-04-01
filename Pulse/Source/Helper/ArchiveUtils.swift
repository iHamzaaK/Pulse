//
//  ArchiveUtils.swift
//  Halal
//
//  Created by Hamza Khan on 13/11/2019.
//  Copyright © 2019 Hamza. All rights reserved.
//

import Foundation

final class ArchiveUtil {
  private static let userDataKey = "userData"
  private static let restaurantDataKey = "restaurantData"
  private static let categoryDataKey = "categoryData"
  private static let userTypeKey = "userType"
  private static let userLocationLat = "userTypeLatitude"
  private static let userLocationLong = "userTypeLongitude"
  private static let userLanguage = "userLanguage"
  private static let restaurantType = "restaurantType"
  private static let signupStep = "signupStep"
  private static let categoriesKey = "categories"
  private static let deviceTokenKey = "deviceToken"
  private static let urlschemeArticleId = "urlSchemeData"
  private static let countryKey = "countries"

  static func saveCategories(categories: [CategoriesData]){
    do{
      let cat = try JSONEncoder().encode([categories])
      UserDefaults.standard.set(cat, forKey: categoriesKey)
    } catch{}
  }

  static func getCategories()-> [CategoriesData]?{
    guard let cat = UserDefaults.standard.data(forKey: categoriesKey) else { return nil}
    do{
      let catData = try JSONDecoder().decode([CategoriesData].self, from: cat)
      return catData
    }
    catch{
      return nil
    }
  }

  static func saveCountries(countries: [Country]) {
    do{
      let countries = try JSONEncoder().encode(countries)
      UserDefaults.standard.set(countries, forKey: countryKey)
    }
    catch{}
  }

  static func getCountries() -> [Country] {
    guard let countries = UserDefaults.standard.data(forKey: countryKey) else { return []}
    do{
      let arrCountries = try JSONDecoder().decode([Country].self, from: countries)
      return arrCountries
    }
    catch{
      return []
    }
  }

  static func saveDeviceToken(deviceToken: String){
    UserDefaults.standard.set(deviceToken, forKey: deviceTokenKey)
  }

  static func getDeviceToken()-> String{
    guard let key =  UserDefaults.standard.object(forKey: deviceTokenKey) as? String else { return ""}
    return key
  }

  static func getUser()-> User?{
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
    UserDefaults.standard.removeObject(forKey: userTypeKey)
  }

  static func saveSession(session: String){}

  static func saveUser(userData: User){
    do{
      let user = try JSONEncoder().encode(userData)
      UserDefaults.standard.set(user, forKey: userDataKey)
    }
    catch{}
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

  static func saveArticleIDFromAppUrlLink(articleId : String){
    UserDefaults.standard.set(articleId, forKey: urlschemeArticleId)

  }

  static func getArticleIDFromAppUrlLink()->String{
    let articleID = UserDefaults.standard.string(forKey: urlschemeArticleId)
    return articleID ?? ""

  }

  static func removeArticleIDFromAppUrlLink(){
    UserDefaults.standard.removeObject(forKey: urlschemeArticleId)
  }

  static func saveUserType(userType : String){
    UserDefaults.standard.set(userType, forKey: userTypeKey)
  }

  static func getUserType()-> userTypes?{
    if let userType = UserDefaults.standard.object(forKey: userTypeKey) as? String{
      if userType == userTypes.author.rawValue{
        return userTypes.author
      }
      return userTypes.viewer
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
}

