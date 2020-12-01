//
//  LoginRepository.swift
//  Pulse
//
//  Created by Hamza Khan on 27/11/2020.
//


import Foundation

protocol LoginRepository{
    func login(userName: String , password : String, completionHandler: @escaping (_ success : Bool,_ message : String) -> Void)
}
