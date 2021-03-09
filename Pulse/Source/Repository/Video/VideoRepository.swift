//
//  VideoRepository.swift
//  Pulse
//
//  Created by FraunhoferWork on 15/12/2020.
//

import Foundation

protocol VideosRepository {
    func getVideos(completionHandler: @escaping ( _ success : Bool , _ serverMsg : String , [ArticleListingData]?)->Void)
}
