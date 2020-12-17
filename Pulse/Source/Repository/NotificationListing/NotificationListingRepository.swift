//
//  NotificationListingRepository.swift
//  Pulse
//
//  Created by FraunhoferWork on 15/12/2020.
//

import Foundation

protocol NotificationListingRepository {
    func getAllNotifications(completionHandler: @escaping ( _ success : Bool , _ serverMsg : String , [ArticleListingData]?)->Void)
    func deleteNotification(completionHandler: @escaping ( _ success : Bool , _ serverMsg : String )->Void)
}
