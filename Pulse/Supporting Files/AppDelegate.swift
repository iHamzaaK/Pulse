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
    // Override point for customization after application launch.
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
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
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
    //        let userInfo = ["identifier":response.notification.request.identifier]
    guard let aps = userInfo["aps"] as? [String: AnyObject] else {
      return
    }
    guard let alert = aps["alert"] as? [String: AnyObject] else {
      return
    }
    print(alert["title"])
    let articleID = alert["body"] as! String
    let application = UIApplication.shared

    if(application.applicationState == .active){
      print("user tapped the notification bar when the app is in foreground")
      AppRouter.presentControllerForNotification(vc: FullArticleBuilder.build(articleID: articleID, headerType: .clearNavBar))
    }

    else if(application.applicationState == .inactive)
    {
      AppRouter.presentControllerForNotification(vc: FullArticleBuilder.build(articleID: articleID, headerType: .clearNavBar))

      print("user tapped the notification bar when the app is in background")
    }
    else {
      if ArchiveUtil.getUserToken() != ""{
        //                Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { (_) in
        AppRouter.presentControllerForNotification(vc: FullArticleBuilder.build(articleID: articleID, headerType: .clearNavBar))
        //                }
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

  //    func application( _ application : UIApplication, continue userActivity: NSUserActivity , restorationHandler: @escaping( [UIUserActivityRestoring]?)->Void)->Bool{
  //
  //        guard let  url = userActivity.webpageURL else { return false }
  //
  //
  //        return false
  //    }
  //pulseapp:article?id=1"
  //    func application(_ application: UIApplication,
  //                     open url: URL,
  //                     options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool {
  //
  //        // Determine who sent the URL.
  //        let sendingAppID = options[.sourceApplication]
  //        print("source application = \(sendingAppID ?? "Unknown")")
  //
  //        // Process the URL.
  //        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
  //              let article = components.path,
  //              let params = components.queryItems else {
  //                  print("Invalid URL or article path missing")
  //                  return false
  //              }
  //
  //        if let articleId = params.first(where: { $0.name == "id" })?.value {
  //            print("article path = \(article)")
  //            print("article Id = \(articleId)")
  //            ArchiveUtil.saveArticleIDFromAppUrlLink(articleId: articleId)
  //
  //            return true
  //        } else {
  //            print("article Id missing")
  //            return false
  //        }
  //        // login page check session
  //        // check if archive util  have this
  //        // go to article detail with article id
  //    }
  func application(_ app: UIApplication, open url: URL,
                   options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    if let scheme = url.scheme,
       scheme.localizedCaseInsensitiveCompare("com.myApp") == .orderedSame,
       let view = url.host {

      var parameters: [String: String] = [:]
      URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.forEach {
        parameters[$0.name] = $0.value
      }

      //            redirect(to: view, with: parameters)
    }
    return true
  }
}

