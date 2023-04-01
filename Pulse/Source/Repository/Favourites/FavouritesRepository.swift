//
//  FavouritesRepository.swift
//  Pulse
//
//  Created by Hamza Khan on 02/12/2020.
//

protocol FavouritesRepository{
  func changeOldPassword(resetCode : String,email : String,password : String, completionHandler: @escaping (Bool, String) -> Void)
}
