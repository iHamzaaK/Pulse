//
//  UserProfileRepositoryImplementation.swift
//  Pulse
//
//  Created by Hamza Khan on 02/12/2020.
//

import Foundation
class UserProfileRepositoryImplementation : UserProfileRepository{
    
    
    private let url = "wp/v2/users/me"
    private var isSuccess = false
    private var serverMsg = ""
    func changeUserProfile(params: [String:String]?, avatar : Data?, completionHandler: @escaping (Bool, String) -> Void) {
        DispatchQueue.main.async{
            ActivityIndicator.shared.showSpinner(nil,title: nil)
        }
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(ArchiveUtil.getUserToken())("
        ]
        if avatar != nil{
            BaseRepository.instance.uploadImage(url: url, method: .post, params: nil,imageData: avatar!, header: headers) { (success,responseMsg,data) in
                self.isSuccess = success
                if success {
                    guard let data = data else {return}
                    let decoder = JSONDecoder()
                    let model = try? decoder.decode(LoginRepo.self, from: data.rawData())
                    guard let success = model?.success else { return }
                    guard let statusMsg = model?.message else { return }
                    self.isSuccess = success
                    self.serverMsg = statusMsg
                    guard let modelData = model?.data else { return }
                    guard let subscription = modelData.subscription else { return}
                    guard let avatar = modelData.avatar else { return}
                    var user = ArchiveUtil.getUser()!
                    user.subscription = subscription
                    user.avatar = avatar
                    ArchiveUtil.saveUser(userData: user)
                }
                completionHandler(self.isSuccess,self.serverMsg)
                
            }
        }
        else{
            BaseRepository.instance.requestService(url: url, method: .post, params: params, header: headers) { (success, serverMsg, data) in
                print(data)
                self.isSuccess = success
                self.serverMsg = serverMsg
                if self.isSuccess{
                    guard let data = data else { return }
                    let decoder = JSONDecoder()
                    let model = try? decoder.decode(LoginRepo.self, from: data.rawData())
                    guard let statusCode = model?.statusCode else { return }
                    self.isSuccess = model?.success ?? false
                    guard let statusMsg = model?.message else { return }
                    self.serverMsg = statusMsg
                    guard let modelData = model?.data else { return }
                    guard let subscription = modelData.subscription else { return}
                    guard let avatar = modelData.avatar else { return}
                    var user = ArchiveUtil.getUser()!
                    user.subscription = subscription
                    user.avatar = avatar
                    ArchiveUtil.saveUser(userData: user)
                }
                completionHandler(self.isSuccess, self.serverMsg)
                
            }
        }
    }
}
