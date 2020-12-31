//
//  CategoriesRepositoryImplementation.swift
//  Pulse
//
//  Created by Hamza Khan on 02/12/2020.
//

import Foundation
class CategoriesRepositoryImplementation : CategoriesRepository{
    
    
    private let url = "wp/v2/sahifa/categories"
    private var isSuccess = false
    private var serverMsg = ""
    func getCategories(completionHandler: @escaping (Bool, String, [CategoriesData]) -> Void) {
        DispatchQueue.main.async{
            ActivityIndicator.shared.showSpinner(nil,title: nil)
        }
//        let params = []
        let headers = [
            "Accept": "application/json",
            "Authorization":  "Bearer " + ArchiveUtil.getUserToken()
        ]
        BaseRepository.instance.requestService(url: url, method: .get, params: nil, header: headers) { (success, serverMsg, data) in
            //print(data)
            self.isSuccess = success
            self.serverMsg = serverMsg
            if self.isSuccess{
                guard let data = data else { return }
                let decoder = JSONDecoder()
                let model = try? decoder.decode(CategoriesRepoModel.self, from: data.rawData())
                guard let statusCode = model?.statusCode else { return }
                self.isSuccess = statusCode != StatusCode.success.rawValue ? false : true
                guard let statusMsg = model?.message else { return }
                self.serverMsg = statusMsg
                
                guard let categoriesData = model?.data else {
                    completionHandler(false, "No Categories available", [])
                    return
                }
                completionHandler(self.isSuccess, self.serverMsg, categoriesData)
            }
            else{
                completionHandler(self.isSuccess, self.serverMsg, [])
            }
            
        }
    }
}
