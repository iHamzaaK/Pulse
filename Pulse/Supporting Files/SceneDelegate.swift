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
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        AppRouter.createRoute(window: self.window!)
//        self.scene(scene, openURLContexts: connectionOptions.urlContexts)
        if let userActivity = connectionOptions.userActivities.first {
            if let incomingURL = userActivity.webpageURL {
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) {

                                handleURL(url: incomingURL)
                        }
                
            }
        }
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) {
//            if let url = connectionOptions.urlContexts.first?.url {
//
//                handleURL(url: url)
//            }
//        }
        
    }
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        if let url = userActivity.webpageURL {
            // ...
            handleURL(url: url)
        }
    }
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }
//        if let scheme = url.scheme,
//           scheme.localizedCaseInsensitiveCompare("pulseapp") == .orderedSame,
//           let view = url.host {
//
//            var parameters: [String: String] = [:]
//            URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.forEach {
//                parameters[$0.name] = $0.value
//            }
//            print(parameters)
            handleURL(url: url)
//            redirect(to: view, with: parameters)
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
            
            //                            let articleID = ArchiveUtil.getArticleIDFromAppUrlLink()
            if articleId != ""{
                let vc = FullArticleBuilder.build(articleID: articleId, headerType: .backButtonWithTitle)
                AppRouter.goToSpecificController(vc: vc)
                
                
            }
            return
        } else {
            print("article Id missing")
            return
        }
    
}

