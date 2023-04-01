//
//  CountriesCellViewModel.swift
//  Pulse
//
//  Created by Hamza Khan on 08.03.22.
//

import Foundation

protocol CountriesCellViewModel {
  func didSelect()
  var country: String { get }
  var isSelected: Bool { get set }
}

class CountriesCellViewModelImplementation: CountriesCellViewModel {
  var country: String
  let image: UIImage? = nil
  var isSelected: Bool
  init(country : String, isSelected: Bool){
    self.country = country
    self.isSelected = isSelected
  }
  func didSelect() {
    isSelected = !isSelected
  }
}
