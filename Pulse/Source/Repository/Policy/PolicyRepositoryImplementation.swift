//
//  PolicyRepositoryImplementation.swift
//  Pulse
//
//  Created by FraunhoferWork on 17/12/2020.
//

import Foundation
class PolicyRepositoryImplementation : PolicyRepository{

    private let url = "wp/v2/sahifa/videos"
    private var isSuccess = false
    private var serverMsg = ""
    func getPolicy(completionHandler: @escaping ( _ success : Bool , _ serverMsg : String )->Void){
        
        
        DispatchQueue.main.async{
            ActivityIndicator.shared.showSpinner(nil,title: nil)
        }
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer " + ArchiveUtil.getUserToken()
        ]
        BaseRepository.instance.requestService(url: url, method: .get, params: nil, header: headers) { (success, serverMsg, data) in
            print(data)
            if success{
//                guard let data = data else { return }
//                let decoder = JSONDecoder()
//                let model = try? decoder.decode(ArticleListingRepoModel.self, from: data.rawData())
//                guard let success = model?.success else { return }
//                let videos = model?.data
//                self.isSuccess = success
//                guard let statusMsg = model?.message else { return }
//                self.serverMsg = statusMsg
                completionHandler(self.isSuccess, self.serverMsg)
            }
            else{
                completionHandler(self.isSuccess, self.serverMsg)
            }
            
        }
    }
}
