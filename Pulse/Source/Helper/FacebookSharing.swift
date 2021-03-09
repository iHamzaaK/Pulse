//
//  FacebookSharing.swift
//  Halal
//
//  Created by hamza Ahmed on 08.02.20.
//  Copyright © 2020 Hamza. All rights reserved.
//
//import UIKit
//import Foundation
//import FBSDKShareKit
//import MobileCoreServices
//
//class FacebookSharing:NSObject,SharingDelegate  {
//
//   static let instance = FacebookSharing()
//   private override init(){}
//    func shareTextOnFaceBook(vc:UIViewController,shareContent:NSString, imageUrl : String) {
//
//        //print(imageUrl)
//      let content = ShareLinkContent()
//    let url = URL(string: imageUrl)
//    content.contentURL = url!
//      content.quote = shareContent as String
//      let dialog = ShareDialog(fromViewController: vc, content: content, delegate: self)
//      dialog.mode = .automatic
//      dialog.show()
//   }
//
//   func sharer(_ sharer: Sharing, didCompleteWithResults results: [String : Any]) {
//      if sharer.shareContent.pageID != nil {
//         ////print("Share: Success")
//      }
//   }
//   func sharer(_ sharer: Sharing, didFailWithError error: Error) {
//      ////print("Share: Fail")
//    //print(error.localizedDescription)
//   }
//   func sharerDidCancel(_ sharer: Sharing) {
//      ////print("Share: Cancel")
//   }
//
//}
//
//






  


















