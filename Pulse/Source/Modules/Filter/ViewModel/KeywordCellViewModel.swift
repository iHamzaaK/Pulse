//
//  KeywordCellViewModel.swift
//  Pulse
//
//  Created by Hamza Khan on 08.03.22.
//

import Foundation

protocol KeywordCellViewModel {
  var keyword: String { get }

}
class KeywordCellViewModelImplementation: KeywordCellViewModel{
  var keyword: String
  init(keyword : String){
    self.keyword = keyword
  }
}
