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
    func getLiked(articleID: String, completionHandler: @escaping (Bool, String, _ isLiked : Bool?) -> Void) {
        DispatchQueue.main.async{
            ActivityIndicator.shared.showSpinner(nil,title: nil)
        }
        let endpoint = articleID
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(ArchiveUtil.getUserToken())"
        ]
        BaseRepository.instance.requestService(url: url+endpoint, method: .get, params: nil, header: headers) { (success, serverMsg, data) in
            print(data)
            self.isSuccess = success
            if self.isSuccess{
                guard let data = data else { return }
                let decoder = JSONDecoder()
                let model = try? decoder.decode(LikesRepoModel.self, from: data.rawData())
                guard let statusCode = model?.statusCode else { return }
                self.isSuccess = statusCode != StatusCode.success.rawValue ? false : true
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
}
