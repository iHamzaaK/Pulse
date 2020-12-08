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
//        let params = [
//            "categories": categories,
//            "password": password
//        ] as [String : Any]
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
                    let model = try? decoder.decode(GeneralRepoModel.self, from: data.rawData())
                    guard let statusCode = model?.success else { return }
                    guard let statusMsg = model?.message else { return }
                    self.isSuccess = success
                    self.serverMsg = statusMsg
                    
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
                    let model = try? decoder.decode(GeneralRepoModel.self, from: data.rawData())
                    guard let statusCode = model?.statusCode else { return }
                    self.isSuccess = statusCode != StatusCode.success.rawValue ? false : true
                    guard let statusMsg = model?.message else { return }
                    self.serverMsg = statusMsg
                }
                completionHandler(self.isSuccess, self.serverMsg)
                
            }
        }
    }
}
