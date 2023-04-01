//
//  NotificationViewModel.swift
//  Pulse
//
//  Created by Hamza Khan on 15/12/2020.
//

struct NotificationListingCellViewModel{
  let title : String
  let image: String
  let tag : String
  let commentCount : Int
  let articleId : Int
  let notificationId : Int

  func getImageURL()->URL?{
    guard let url = URL.init(string: image) else { return nil}
    return url
  }
}

final class NotificationListingViewModel {
  private let headerTitle = ""
  private let repo : NotificationListingRepository
  private let navBarType : navigationBarTypes
  var notificationArr : [NotificationData] = []

  init(navigationType navBar : navigationBarTypes, repo : NotificationListingRepository) {
    self.navBarType = navBar
    self.repo = repo
  }

  func getNavigationBar()-> navigationBarTypes{
    return navBarType
  }

  func getAllNotifications(completionHandler: @escaping ( _ success : Bool , _ serverMsg : String)->Void){
    self.repo.getAllNotifications { (success, serverMsg, data) in
      guard let data = data else {
        completionHandler(false, "Invalid Response")
        return
      }
      self.notificationArr = data
      completionHandler(success, serverMsg)
    }
  }

  func didTapOnDelete(row: Int, completionHandler : @escaping (_ success : Bool , _ serverMsg : String)->Void){
    guard let notificationId = notificationArr[row].notificationId else { return }
    self.repo.deleteNotification(notificationId: String(notificationId)) { (success, serverMsg) in
      if success{
        self.notificationArr.remove(at: row)
      }
      completionHandler(success,serverMsg)
    }
  }

  func getNotificationArrCount()->Int{
    return notificationArr.count
  }

  func cellViewModelForRow(row: Int)-> NotificationListingCellViewModel{
    let notification = notificationArr[row]

    let cellViewModel = NotificationListingCellViewModel(title: notification.title ?? "", image: notification.image ?? "", tag: notification.tag ?? "", commentCount: notification.noOfComments ?? 0, articleId : notification.articleId ?? -1, notificationId: notification.notificationId ?? -1)
    return cellViewModel
  }

  func didTapOnCell(row: Int, completionHandler:( _ vc : UIViewController?)->Void){
    let notification = notificationArr[row]
    guard let articleId = notification.articleId else { completionHandler(nil)
      return
    }
    let articleID = String(articleId)
    let vc = FullArticleBuilder.build(articleID: articleID, headerType: .backButtonWithRightMenuButton)
    completionHandler(vc)
  }
}
