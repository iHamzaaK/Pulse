//
//  LikesRepositoryImplementation.swift
//  Pulse
//
//  Created by Hamza Khan on 02/12/2020.
//

import Foundation
class LikesRepositoryImplementation : LikesRepository{
    
    
    
    private let url = "wp/v2/sahifa/post/likes/"
    private var isSuccess = false
    private var serverMsg = ""
    let headers = [
        "Accept": "application/json",
        "Authorization": "Bearer \(ArchiveUtil.getUserToken())",
        "Content-Type": "application/x-www-form-urlencoded"

    ]
    func getLiked(articleID: String, completionHandler: @escaping (Bool, String, _ isLiked : Bool?) -> Void) {
        
        let endpoint = articleID
       
        BaseRepository.instance.requestService(url: url+endpoint, method: .get, params: nil, header: headers,showSpinner: false) { (success, serverMsg, data) in
            //print(data)
            self.isSuccess = success
            if self.isSuccess{
                guard let data = data else { return }
                let decoder = JSONDecoder()
                let model = try? decoder.decode(LikesRepoModel.self, from: data.rawData())
                guard let statusCode = model?.statusCode else { return }
                self.isSuccess = model?.success ?? false//statusCode != StatusCode.success.rawValue ? false : true
                guard let statusMsg = model?.message else { return }
                self.serverMsg = statusMsg
                let isLiked = model?.is_liked
                completionHandler(self.isSuccess, self.serverMsg, isLiked)

            }
            else{
            completionHandler(self.isSuccess, self.serverMsg, nil)
            }
            
        }
    }
    func getAllLikes(articleID: String, completionHandler: @escaping (Bool, String,  _ userLikedArr : [AllLikesData]?) -> Void) {
        
        let endpoint = "list/\(articleID)"
        BaseRepository.instance.requestService(url: url+endpoint, method: .get, params: nil, header: headers, showSpinner: false) { (success, serverMsg, data) in
            //print(data)
            self.isSuccess = success
            if self.isSuccess{
                guard let data = data else { return }
                let decoder = JSONDecoder()
                let model = try? decoder.decode(AllLikesRepoModel.self, from: data.rawData())
                self.isSuccess = model?.success ?? false//statusCode != StatusCode.success.rawValue ? false : true
                guard let statusMsg = model?.message else { return }
                self.serverMsg = statusMsg
                let usersLikedArr = model?.data
                completionHandler(self.isSuccess, self.serverMsg, usersLikedArr)

            }
            else{
                completionHandler(self.isSuccess, self.serverMsg, nil)
            }
        }
        
    }
    
}
