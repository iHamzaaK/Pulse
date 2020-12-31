//
//  NotificationListingRepositoryImplementation.swift
//  Pulse
//
//  Created by FraunhoferWork on 15/12/2020.
//

import Foundation
class NotificationListingRepositoryImplementation : NotificationListingRepository{

    private var url = "wp/v2/sahifa/notifications/me"
    private var isSuccess = false
    private var serverMsg = ""
    func getAllNotifications(completionHandler: @escaping ( _ success : Bool , _ serverMsg : String , [NotificationData]?)->Void){
        
        
        DispatchQueue.main.async{
            ActivityIndicator.shared.showSpinner(nil,title: nil)
        }
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer " + ArchiveUtil.getUserToken()
        ]
        BaseRepository.instance.requestService(url: url, method: .get, params: nil, header: headers) { (success, serverMsg, data) in
            //print(data)
            if success{
                guard let data = data else { return }
                let decoder = JSONDecoder()
                let model = try? decoder.decode(NotificationRepoModel.self, from: data.rawData())
                guard let success = model?.success else { return }
                let notificationData = model?.data
                self.isSuccess = success
                guard let statusMsg = model?.message else { return }
                self.serverMsg = statusMsg
                completionHandler(self.isSuccess, self.serverMsg, notificationData)
            }
            else{
                completionHandler(self.isSuccess, self.serverMsg, nil)
            }
            
        }
    }
    func deleteNotification(notificationId: String, completionHandler: @escaping (Bool, String) -> Void) {
        DispatchQueue.main.async{
            ActivityIndicator.shared.showSpinner(nil,title: nil)
        }
        url = "wp/v2/sahifa/notification/dismiss/\(notificationId)"
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer " + ArchiveUtil.getUserToken()
        ]
        BaseRepository.instance.requestService(url: url, method: .get, params: nil, header: headers) { (success, serverMsg, data) in
            //print(data)
            if success{
                guard let data = data else { return }
                let decoder = JSONDecoder()
                let model = try? decoder.decode(GeneralRepoModel.self, from: data.rawData())
                guard let success = model?.success else { return }
                self.isSuccess = success
                guard let statusMsg = model?.message else { return }
                self.serverMsg = statusMsg
                completionHandler(self.isSuccess, self.serverMsg)
            }
            else{
                completionHandler(self.isSuccess, self.serverMsg)
            }
            
        }
    }
}
