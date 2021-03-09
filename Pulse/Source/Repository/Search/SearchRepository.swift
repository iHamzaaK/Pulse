//
//  SearchRepository.swift
//  Pulse
//
//  Created by Hamza Khan on 02/12/2020.
//

import Foundation
protocol SearchRepository{
    func search(searchText: String, limit: Int, completionHandler: @escaping (Bool, String, _ searchData : [SearchData]?) -> Void)
}

