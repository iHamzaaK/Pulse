//
//  PolicyRepository.swift
//  Pulse
//
//  Created by FraunhoferWork on 17/12/2020.
//

import Foundation


protocol PolicyRepository {
    func getPolicy(completionHandler: @escaping ( _ success : Bool , _ serverMsg : String)->Void)
}
