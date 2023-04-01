//
//  SearchRepository.swift
//  Pulse
//
//  Created by Hamza Khan on 02/12/2020.
//

protocol SearchRepository{
  func search(searchText: String, dateTime: Int, limit: Int, completionHandler: @escaping (Bool, String, _ searchData : [SearchData]?) -> Void)
}

