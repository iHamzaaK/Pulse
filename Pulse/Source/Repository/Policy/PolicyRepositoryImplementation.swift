//
//  PolicyRepositoryImplementation.swift
//  Pulse
//
//  Created by Hamza Khan on 17/12/2020.
//

import Foundation

final class PolicyRepositoryImplementation : PolicyRepository{
  private let url = "wp/v2/sahifa/"
  private var isSuccess = false
  private var serverMsg = ""
  func getPolicy(endpoint : String, completionHandler: @escaping ( _ success : Bool , _ serverMsg : String, _ content : String )->Void){
    DispatchQueue.main.async{
      ActivityIndicator.shared.showSpinner(nil,title: nil)
    }
    let headers = [
      "Accept": "application/json",
      "Authorization": "Bearer " + ArchiveUtil.getUserToken(),
      "Content-Type": "application/x-www-form-urlencoded"
    ]
    BaseRepository.instance.requestService(url: url+endpoint , method: .get, params: nil, header: headers) { (success, serverMsg, data) in
      if success{
        guard let data = data else { return }
        let decoder = JSONDecoder()
        let model = try? decoder.decode(PolicyRepoModel.self, from: data.rawData())
        guard let success = model?.success else { return }
        let content = model?.data?.descriptionField
        self.isSuccess = success
        guard let statusMsg = model?.message else { return }
        self.serverMsg = statusMsg
        completionHandler(self.isSuccess, self.serverMsg, content ?? "")
      }
      else{
        completionHandler(self.isSuccess, self.serverMsg, "")
      }
    }
  }
}
