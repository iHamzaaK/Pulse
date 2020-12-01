//
//  ConfirmPasswordRepository.swift
//  Pulse
//
//  Created by Hamza Khan on 01/12/2020.
//

import Foundation
protocol ConfirmPasswordRepository{
    func changeOldPassword(resetCode : String,email : String,password : String, completionHandler: @escaping (Bool, String) -> Void)
}
