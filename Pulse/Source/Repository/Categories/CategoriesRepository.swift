//
//  CategoriesRepository.swift
//  Pulse
//
//  Created by Hamza Khan on 02/12/2020.
//

protocol CategoriesRepository{
  func getCategories(completionHandler: @escaping (Bool, String, [CategoriesData]) -> Void)
}
