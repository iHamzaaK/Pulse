//
//  SceneDelegate.swift
//  Pulse
//
//  Created by Hamza Khan on 06/11/2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    self.window = UIWindow(windowScene: windowScene)

    AppRouter.createRoute(window: self.window!)
    if let userActivity = connectionOptions.userActivities.first {
      if let incomingURL = userActivity.webpageURL {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) {
          handleURL(url: incomingURL)
        }
      }
    }
  }

  func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
    if let url = userActivity.webpageURL {
      handleURL(url: url)
    }
  }

  func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    guard let url = URLContexts.first?.url else {
      return
    }
    handleURL(url: url)
  }
}

private func handleURL(url : URL){
  guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
        let article = components.path,
        let params = components.queryItems else {
    print("Invalid URL or article path missing")
    return
  }

  if let articleId = params.first(where: { $0.name == "id" })?.value {
    print("article path = \(article)")
    print("article Id = \(articleId)")
    ArchiveUtil.saveArticleIDFromAppUrlLink(articleId: articleId)
    if articleId != ""{
      let vc = FullArticleBuilder.build(articleID: articleId, headerType: .backButtonWithTitle)
      AppRouter.goToSpecificController(vc: vc)
    }
    return
  }
  return
}

