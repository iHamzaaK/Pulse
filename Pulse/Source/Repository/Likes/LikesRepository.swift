//
//  LikesRepository.swift
//  Pulse
//
//  Created by Hamza Khan on 02/12/2020.
//

import Foundation
protocol LikesRepository{
    func changeOldPassword(resetCode : String,email : String,password : String, completionHandler: @escaping (Bool, String) -> Void)
}
