//
//  OTPRepository.swift
//  Pulse
//
//  Created by Hamza Khan on 01/12/2020.
//

protocol OTPRepository{
  func sendOTP(otp : String, email:String, completionHandler: @escaping (Bool, String) -> Void)
}
