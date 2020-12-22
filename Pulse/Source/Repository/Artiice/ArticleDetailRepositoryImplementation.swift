//
//  ArticleDetailRepositoryImplementation.swift
//  Pulse
//
//  Created by FraunhoferWork on 10/12/2020.
//

import Foundation
class ArticleDetailRepositoryImplementation : ArticleDetailRepository{
    
    

    private let url = "wp/v2/sahifa/post/detail/"
    private var isSuccess = false
    private var serverMsg = ""
    func getArticleDetail(articleID: String, completionHandler: @escaping (Bool, String, [PostDetailData]? , [PostDetailComment]?) -> Void) {

        var endpoint = "\(articleID)?comments=10"
        
        
        DispatchQueue.main.async{
            ActivityIndicator.shared.showSpinner(nil,title: nil)
        }
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer " + ArchiveUtil.getUserToken()
        ]
        BaseRepository.instance.requestService(url: url + endpoint, method: .get, params: nil, header: headers) { (success, serverMsg, data) in
            print(data)
            self.isSuccess = success
            self.serverMsg = serverMsg
            if self.isSuccess{
                guard let data = data else { return }
                let decoder = JSONDecoder()
                let model = try? decoder.decode(PostDetailRepo.self, from: data.rawData())
                guard let success = model?.success else { return }
                let articleData = model?.data
                let articleCommments = model?.comments
                self.isSuccess = success
                
                guard let statusMsg = model?.message else { return }
                self.serverMsg = statusMsg
                completionHandler(self.isSuccess,serverMsg, articleData, articleCommments)
                
            }
            else{
                completionHandler(self.isSuccess, self.serverMsg, nil, nil)
            }
            
        }
    }
}
