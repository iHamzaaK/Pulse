//
//  BookmarksRepositoryImplementation.swift
//  Pulse
//
//  Created by Hamza Khan on 02/12/2020.
//

import Foundation
class BookmarksRepositoryImplementation : BookmarksRepository{
    
    
    
    
    private let url = "wp/v2/sahifa/bookmarks/add"
    private var isSuccess = false
    private var serverMsg = ""
    func adddRemoveBookmark(id: String, completionHandler: @escaping (Bool, String) -> Void) {
        
        let params = [
            "id": id,
        ]
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(ArchiveUtil.getUserToken())"
        ]
        BaseRepository.instance.requestService(url: url, method: .post, params: params, header: headers, showSpinner: false) { (success, serverMsg, data) in
            //print(data)
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
