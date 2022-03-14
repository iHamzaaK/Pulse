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
    func search(searchText: String, dateTime: Int, limit: Int, completionHandler: @escaping (Bool, String, _ searchData : [SearchData]?) -> Void)
    {
//       let test = wp/v2/sahifa/posts/search?s=COVID &limit=6
        let endpoint = "s=\(searchText)&date=\(dateTime)&limit=\(limit)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer " + ArchiveUtil.getUserToken(),
            "Content-Type": "application/x-www-form-urlencoded"

        ]
        BaseRepository.instance.requestService(url: url+endpoint, method: .get, params: nil, header: headers, showSpinner: false) { (success, serverMsg, data) in
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
