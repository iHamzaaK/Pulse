//
//  LoginRepositoryImplementation.swift
//  Pulse
//
//  Created by Hamza Khan on 27/11/2020.
//

import Foundation
import Alamofire
import Alamofire_SwiftyJSON
class LoginRepositoryImplementation: LoginRepository{
    
    
    private let loginUrl = "jwt-auth/v1/token"
    private var isSuccess = false
    private var serverMsg = ""
    
    
    
    func login(userName: String, password: String, completionHandler: @escaping (_ success : Bool,_ message : String) -> Void) {
        
        let params = [
            "password": password,
            "username": userName,
//            "deviceToken": deviceUDID ,
//            "deviceName": deviceName
        ]
        let header = ["":""]
        BaseRepository.instance.requestService(url: loginUrl, method: .post, params: params, header: header) { (success, serverMsg, data) in
            if success{
                guard let data = data else {return}
                
                let decoder = JSONDecoder()
                let model = try? decoder.decode(LoginRepo.self, from: data.rawData())
                guard let statusCode = model?.statusCode else { return }
                guard let statusMsg = model?.message else { return }
                self.isSuccess = success
                if statusCode != StatusCode.success.rawValue{
                    self.isSuccess = false
                    self.serverMsg = statusMsg
                    completionHandler(self.isSuccess, self.serverMsg)

                }
                else{
                    guard let modelData = model?.data else { return }
                    guard let accessToken = modelData.token else { return }
                    guard let userID = modelData.id else{return}
//                    guard let userType = modelData.dashboard?.user?.type else { return }
                    guard let userEmail = modelData.email else{return}
//                    guard let userStatus = modelData.dashboard?.user?.status else{return}
                    guard let userFirstName = modelData.firstName else{return}
                    guard let userLastName = modelData.lastName else{return}
                    guard let userDisplayNaame = modelData.displayName else{return}
                    let user = User(id: userID, firstName: userFirstName, lastName: userLastName, displayName: userDisplayNaame, email: userEmail, password: password, accessToken: accessToken)
                        ArchiveUtil.saveUser(userData: user)
                    }
                    completionHandler(self.isSuccess, self.serverMsg)

                    
                
            }
            else{
                self.serverMsg = serverMsg
                self.isSuccess = false
                completionHandler(self.isSuccess, self.serverMsg)
            }
            
        }
    }
    
    
}
