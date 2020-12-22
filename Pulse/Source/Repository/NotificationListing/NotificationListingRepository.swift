//
//  NotificationListingRepository.swift
//  Pulse
//
//  Created by FraunhoferWork on 15/12/2020.
//

import Foundation

protocol NotificationListingRepository {
    func getAllNotifications(completionHandler: @escaping ( _ success : Bool , _ serverMsg : String , [NotificationData]?)->Void)
    func deleteNotification(notificationId : String, completionHandler: @escaping ( _ success : Bool , _ serverMsg : String )->Void)
}
