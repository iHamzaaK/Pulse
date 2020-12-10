//
//  BookmarksRepository.swift
//  Pulse
//
//  Created by Hamza Khan on 02/12/2020.
//

import Foundation
protocol BookmarksRepository{
    func adddRemoveBookmark(id: String, completionHandler: @escaping (Bool, String) -> Void)
}
