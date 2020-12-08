//
//  SearchRepositoryImplementation.swift
//  Pulse
//
//  Created by Hamza Khan on 02/12/2020.
//

import Foundation
import Foundation
class SearchRepositoryImplementation : SearchRepository{
    
    
    private let url = "wp/v2/sahifa/posts/search?"
    private var isSuccess = false
    private var serverMsg = ""
    func search(searchText: String, limit: Int, completionHandler: @escaping (Bool, String, _ searchData : [SearchData]?) -> Void)
    {
        DispatchQueue.main.async{
            ActivityIndicator.shared.showSpinner(nil,title: nil)
        }
        let endpoint = "s=\(searchText)&limit=\(limit)"
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer " + ArchiveUtil.getUserToken()
        ]
        BaseRepository.instance.requestService(url: url+endpoint, method: .get, params: nil, header: headers) { (success, serverMsg, data) in
            print(data)
            self.isSuccess = success
            self.serverMsg = serverMsg
            if self.isSuccess{
                guard let data = data else { return }
                let decoder = JSONDecoder()
                let model = try? decoder.decode(SearchRepo.self, from: data.rawData())
                guard let success = model?.success else { return }
                self.isSuccess = success
                guard let statusMsg = model?.message else { return }
                self.serverMsg = statusMsg
                guard let searchData = model?.data else { return }
                completionHandler(self.isSuccess, self.serverMsg, searchData)

            }
            else{
                completionHandler(self.isSuccess, self.serverMsg, nil)
            }
            
        }
    }
}
