//
//  PolicyRepository.swift
//  Pulse
//
//  Created by Hamza Khan on 17/12/2020.
//

protocol PolicyRepository {
  func getPolicy(endpoint : String ,completionHandler: @escaping ( _ success : Bool , _ serverMsg : String, _ content : String)->Void)
}
