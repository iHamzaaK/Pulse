//
//  BaseRepository.swift
//  Halal
//
//  Created by Hamza Khan on 19/11/2019.
//  Copyright © 2019 Hamza. All rights reserved.
//

import Foundation
import Alamofire
import Alamofire_SwiftyJSON
import SwiftyJSON
class BaseRepository{
   static let instance = BaseRepository()
   private init(){}
    /*
   func requestService(url : String , method: HTTPMethod, params : Parameters?, header : HTTPHeaders, showSpinner: Bool? = true, completionHandler: @escaping (_ isSuccess : Bool, _ serverMsg : String,_ data: JSON?)->Void){
      if showSpinner ?? true{
         DispatchQueue.main.async{
            ActivityIndicator.shared.showSpinner(nil, title: nil)
         }
      }
      let requestURL = URL(string:baseURL + url)!
      let serviceRequest = request(requestURL, method: method, parameters: params, encoding: URLEncoding.default, headers: header )
      serviceRequest.responseSwiftyJSON { (response) in
         if showSpinner ?? true  {
            DispatchQueue.main.async{
               ActivityIndicator.shared.hideSpinner()
            }
         }
         if response.error == nil{
            guard let data = response.value else { return }
            guard let statusCode = data["statusCode"].int
               else { return }
            if statusCode == StatusCode.authExpired.rawValue{
               completionHandler(false,"",nil)
               AppRouter.logout()
            }
            completionHandler(true,"",data )
            
         }
         else{
            let msg = response.error?.localizedDescription
            completionHandler(false,msg ?? "Something went wrong. Please try again.",nil)
         }
         
      }
      
   }
   func uploadImage(url : String , method: HTTPMethod, params : Parameters?, imageData : Data, header : HTTPHeaders, completionHandler: @escaping (_ isSuccess : Bool, _ serverMsg : String, _ data:JSON?)->Void){
      DispatchQueue.main.async{
         ActivityIndicator.shared.showSpinner(nil, title: nil)
      }
      let param: [String:Any] = params ?? [:]
      let requestURL = URL(string:baseURL + url)!
      // var responceData:[String:Any]?
      Alamofire.upload(multipartFormData: { (multiFormData) in
         multiFormData.append(imageData, withName: "arrRestaurantImages",fileName: "halal.jpg" , mimeType: "image/jpg")
         
         for (key, value) in param {
            multiFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
         }
         
         
      }, usingThreshold: UInt64.init(), to: requestURL, method: method, headers: header) { (encodingResult) in
         switch encodingResult{
         case .success(let upload, _, _):
            upload.responseSwiftyJSON { response in
               DispatchQueue.main.async{
                  ActivityIndicator.shared.hideSpinner()
               }
               if response.error == nil{
                  guard let data = response.value else { return }
                  guard let statusCode = data["statusCode"].int
                     else { return }
                  if statusCode == StatusCode.authExpired.rawValue{
                     completionHandler(false,"",nil)
                     AppRouter.logout()
                  }
                  completionHandler(true,"",data )
                  
               }
               else{
                  let msg = response.error?.localizedDescription
                  completionHandler(false,msg ?? "Something went wrong. Please try again.",nil)
               }
            }
         case .failure(let encodingError):
            //print(encodingError)
            completionHandler(false,"Image can not be uploaded!",nil)
            DispatchQueue.main.async{
               ActivityIndicator.shared.hideSpinner()
            }
            
         }
      }
   }
 */
   
}
