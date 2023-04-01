//
//  VideosViewModel.swift
//  Pulse
//
//  Created by Hamza Khan on 14/11/2020.
//

import UIKit

final class VideosViewModel {
  let headerTitle = ""
  private let navBarType : navigationBarTypes
  let repository : VideosRepository
  var arrVideos : [ArticleListingData] = []
  let type : articleListingType

  init(navigationType navBar : navigationBarTypes, repo : VideosRepository, type : articleListingType) {
    self.navBarType = navBar
    self.repository = repo
    self.type = type
  }

  func getNavigationBar()-> navigationBarTypes{
    return navBarType
  }

  func getAllVideos(completionHandler: @escaping ( _ success :Bool , _ serverMsg : String )->Void){
    self.repository.getVideos { (success, serverMsg, data) in
      if success{
        guard let data = data else {
          completionHandler(false, "Invalid Response")
          return
        }
        self.arrVideos = data
      }
      completionHandler(success, serverMsg)
    }
  }

  func getVideosCount()->Int{
    return arrVideos.count
  }

  func cellViewModelForRow(row: Int)-> ArticleListingCellViewModel{
    let video = arrVideos[row]
    let cellViewModel = ArticleListingCellViewModel(articleID: video.id ?? -1, title: video.title ?? "", permalink: video.permalink ?? "", thumbnail: video.thumbnail ?? "", description: video.descriptionField ?? "", isVideo: video.isVideo ?? false, videoURL: video.videoUrl ?? "", type: self.type, shortDescription: video.shortDescription , date: video.date, tag: video.tag ?? "Uncategorized" , isBookmarked: video.isBookmarked , isLiked: video.isLiked , likeCount: video.likeCount )
    return cellViewModel
  }
}
