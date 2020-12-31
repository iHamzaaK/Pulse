//
//  CommentsRepositoryImplementation.swift
//  Pulse
//
//  Created by Hamza Khan on 02/12/2020.
//

import Foundation
class CommentsRepositoryImplementation: CommentsRepository{
    
    
    
    
    private var url = "wp/v2/sahifa/post/comments/"
    private var isSuccess = false
    private var serverMsg = ""
    func getAllComments(articleID : String, completionHandler: @escaping (Bool, String, [PostDetailComment]?) -> Void) {
        DispatchQueue.main.async{
            ActivityIndicator.shared.showSpinner(nil,title: nil)
        }
        let endPoint = "\(articleID)?limit=100000"
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(ArchiveUtil.getUserToken())"
        ]
        BaseRepository.instance.requestService(url: url + endPoint, method: .get, params: nil, header: headers) { (success, serverMsg, data) in
            //print(data)
            
                guard let data = data else { return }
                let decoder = JSONDecoder()
                let model = try? decoder.decode(CommentRepoModel.self, from: data.rawData())
                guard let statusCode = model?.statusCode else { return }
                self.isSuccess = model?.success ?? false
                guard let statusMsg = model?.message else { return }
                self.serverMsg = statusMsg
            if self.isSuccess{
                let commentData = model?.data
                completionHandler(self.isSuccess,self.serverMsg,commentData)
            }
            else{
            completionHandler(self.isSuccess,self.serverMsg,nil)
            }

        }
    }
    func postComment(id: String, comment: String, completionHandler: @escaping (Bool, String, PostDetailComment?) -> Void) {
        url = "wp/v2/sahifa/post/comment/create/\(id)"
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(ArchiveUtil.getUserToken())"
        ]
        let params = [
            "id": id,
            "comment": comment
        ]
        
        BaseRepository.instance.requestService(url: url, method: .post, params: params, header: headers) { (success, serverMsg, data) in
            //print(data)
                guard let data = data else { return }
                let decoder = JSONDecoder()
                let model = try? decoder.decode(CommentRepoModel.self, from: data.rawData())
                self.isSuccess = model?.success ?? false
                guard let statusMsg = model?.message else { return }
                self.serverMsg = statusMsg
            if self.isSuccess{
                let commentData = model?.data!.first 
                completionHandler(self.isSuccess, self.serverMsg, commentData)
            }
            else{
                completionHandler(self.isSuccess,self.serverMsg,nil)
            }

         }
    }
   
}

