//
//  PolicyRepository.swift
//  Pulse
//
//  Created by FraunhoferWork on 17/12/2020.
//

import Foundation


protocol PolicyRepository {
    func getPolicy(endpoint : String ,completionHandler: @escaping ( _ success : Bool , _ serverMsg : String, _ content : String)->Void)
}
