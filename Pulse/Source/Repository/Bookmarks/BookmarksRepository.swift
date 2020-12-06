//
//  BookmarksRepository.swift
//  Pulse
//
//  Created by Hamza Khan on 02/12/2020.
//

import Foundation
protocol BookmarksRepository{
    func changeOldPassword(resetCode : String,email : String,password : String, completionHandler: @escaping (Bool, String) -> Void)
}
