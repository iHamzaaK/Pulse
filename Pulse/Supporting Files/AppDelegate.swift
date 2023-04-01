//
//  AppDelegate.swift
//  Pulse
//
//  Created by Hamza Khan on 06/11/2020.
//

import UIKit
import IQKeyboardManagerSwift
import UserNotifications
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes

@main
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate {


  let notificationCenter = UNUserNotificationCenter.current()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    IQKeyboardManager.shared.enable = true
    registerForPushNotifications()
    notificationCenter.delegate = self

    let appearance = UITabBarItem.appearance()
    let attributes = [NSAttributedString.Key.font:UIFont(name: "Montserrat-Medium", size: DesignUtility.convertToRatio(10, sizedForIPad:  DesignUtility.isIPad, sizedForNavi: false))]
    appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)

    AppCenter.start(withAppSecret: "9a37aaf2-b3e0-473b-aece-7bc0eff7203c", services:[
      Analytics.self,
      Crashes.self
    ])

    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func getNotificationSettings() {
    UNUserNotificationCenter.current().getNotificationSettings { settings in
      print("Notification settings: \(settings)")
      guard settings.authorizationStatus == .authorized else { return }
      DispatchQueue.main.async {
        UIApplication.shared.registerForRemoteNotifications()
      }
    }
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.banner, .sound])

  }

  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo
    guard let aps = userInfo["aps"] as? [String: AnyObject] else {
      return
    }

    guard let alert = aps["alert"] as? [String: AnyObject] else {
      return
    }

    let articleID = alert["body"] as! String
    let application = UIApplication.shared

    if(application.applicationState == .active) {
      print("user tapped the notification bar when the app is in foreground")
      AppRouter.presentControllerForNotification(vc: FullArticleBuilder.build(articleID: articleID, headerType: .clearNavBar))
    }

    else if(application.applicationState == .inactive) {
      AppRouter.presentControllerForNotification(vc: FullArticleBuilder.build(articleID: articleID, headerType: .clearNavBar))
      print("user tapped the notification bar when the app is in background")
    }
    else {
      if ArchiveUtil.getUserToken() != ""{
        AppRouter.presentControllerForNotification(vc: FullArticleBuilder.build(articleID: articleID, headerType: .clearNavBar))
      }
    }
    completionHandler()

  }
  func registerForPushNotifications() {
    UNUserNotificationCenter.current()
      .requestAuthorization(
        options: [.alert, .sound, .badge]) { [weak self] granted, _ in
          print("Permission granted: \(granted)")
          guard granted else { return }
          self?.getNotificationSettings()
        }
  }
  func application(
    _ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
  ) {
    let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
    let token = tokenParts.joined()
    print("Device Token: \(token)")
    ArchiveUtil.saveDeviceToken(deviceToken: token)
  }
  func application(
    _ application: UIApplication,
    didFailToRegisterForRemoteNotificationsWithError error: Error
  ) {
    print("Failed to register: \(error)")
  }

  func application(_ app: UIApplication, open url: URL,
                   options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    if let scheme = url.scheme,
       scheme.localizedCaseInsensitiveCompare("com.myApp") == .orderedSame,
       let view = url.host {

      var parameters: [String: String] = [:]
      URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.forEach {
        parameters[$0.name] = $0.value
      }
    }
    return true
  }
}

