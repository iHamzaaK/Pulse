//
//  VideoRepository.swift
//  Pulse
//
//  Created by Hamza Khan on 15/12/2020.
//

protocol VideosRepository {
  func getVideos(completionHandler: @escaping ( _ success : Bool , _ serverMsg : String , [ArticleListingData]?)->Void)
}
