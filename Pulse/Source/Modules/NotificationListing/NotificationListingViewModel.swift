//
//  NotificationViewModel.swift
//  Pulse
//
//  Created by FraunhoferWork on 15/12/2020.
//

class NotificationListingViewModel {
    
    let headerTitle = ""
    private let navBarType : navigationBarTypes!
    let notificationArr : [AllLikesData] = []
    let repo : NotificationListingRepository!
    init(navigationType navBar : navigationBarTypes, repo : NotificationListingRepository) {
        self.navBarType = navBar
        self.repo = repo
    }
    func getNavigationBar()-> navigationBarTypes{
        return navBarType
    }
    func getAllNotifications(completionHandler: @escaping ( _ success : Bool , _ serverMsg : String)->Void){
        self.repo.getAllNotifications { (success, serverMsg, data) in
            
            completionHandler(success, serverMsg)
        }
    }
    func didTapOnDelete(row: Int){
        self.repo.deleteNotification { (success, serverMsg) in
            
        }
    }
    func getNotificationArrCount()->Int{
        return 10//notificationArr.count
    }
    func cellViewModelForRow(row: Int)-> NotificationListingCellViewModel{
//        let userLike = notificationArr[row]
        let cellViewModel = NotificationListingCellViewModel(title: "hahahhahahah", image: "", tag: "gaga", commentCount: 10)
        return cellViewModel
    }
}
struct NotificationListingCellViewModel{
    let title : String
    let image: String
    let tag : String
    let commentCount : Int
    
    func getImageURL()->URL?{
        guard let url = URL.init(string: image) else { return nil}
        return url
    }
}
