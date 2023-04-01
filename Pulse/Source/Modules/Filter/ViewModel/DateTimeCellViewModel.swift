//
//  DateTimeCellViewModel.swift
//  Pulse
//
//  Created by Hamza Khan on 08.03.22.
//

import Foundation

protocol DateTimeCellViewModel {
  func didSelect() -> Void
  var dateTime: String { get }
  var isSelected: Bool { get set } 
}

final class DateTimeCellViewModelImplementation: DateTimeCellViewModel{
  var dateTime: String
  var isSelected: Bool
  init(dateTime: String, isSelected: Bool){
    self.dateTime = dateTime
    self.isSelected = isSelected
  }
  
  func didSelect() {
    isSelected = !isSelected
  }

}
