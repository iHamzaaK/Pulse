//
//  ForgetPasswordRepository.swift
//  Pulse
//
//  Created by Hamza Khan on 01/12/2020.
//

protocol ForgetPasswordRepositoryProtocol{
  func resetPassword(email : String, completionHandler: @escaping (Bool, String) -> Void)
}
