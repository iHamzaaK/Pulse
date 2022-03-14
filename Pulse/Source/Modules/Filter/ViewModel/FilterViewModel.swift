//
//  FilterViewModel.swift
//  Pulse
//
//  Created by Hamza Khan on 07.03.22.
//

import Foundation

protocol FilterViewModel {
  func getDateTimeFilterArray() -> [String]
  func sectionsForCollectionView(tag: Int) -> Int
  func heightForSectionHeader(section: Int, tag: Int) -> Int
  func title(forSection section: Int) -> String
  func rowsForSection(section : Int, tag: Int) -> Int
  func addKeywords(keyword: String)
  func dataForRow(section: Int, row: Int) -> String
  func cellViewModel(for row: Int) -> KeywordCellViewModel
  func cellViewModel(for row: Int) -> DateTimeCellViewModel
  func cellViewModel(for row: Int) -> CountriesCellViewModel
  func didDeleteKeyword(for row: Int)
//  func didSelectItem(for row: Int, section: Int)
  var selectedDateTime: Int { get set }
  var selectedCountry: String { get set }
  func getCountries() -> [Country]
  func sizeForItem(row: Int, section: Int, tag: Int) -> CGSize
  func collectionViewHeight() -> Int
  func getNavigationBar()-> navigationBarTypes
  func getAllFilters() -> SelectedFilters
}
final class FilterViewModelImplementation: FilterViewModel {

  private let navBar : navigationBarTypes!
  var arrKeywords: [String]
  var arrCountries: [Country]
  var arrDateTime: [String]
  var selectedDateTime = 0
  var selectedCountry = ""

  init(navBar: navigationBarTypes){
    self.navBar = navBar
    self.arrKeywords = []
    self.arrCountries = ArchiveUtil.getCountries()
    self.arrDateTime = DateTimeFilter.allFilters()

  }
  func getNavigationBar()-> navigationBarTypes{
    return navBar
  }
  func getCountries() -> [Country] {
    arrCountries
  }
  func getDateTimeFilterArray() -> [String]{
    DateTimeFilter.allFilters()
  }
  func sectionsForCollectionView(tag: Int) -> Int {
    if tag == 0 {
      return 2
    }
    return 1
  }

  func collectionViewHeight() -> Int {
    return arrKeywords.count * 35
  }
  func addKeywords(keyword: String) {
    self.arrKeywords.append(keyword)
  }
  func rowsForSection(section : Int, tag: Int) -> Int {
    if tag == 0 {
      if section == 0{
      return arrKeywords.count
      }
      return arrCountries.count
    }
    else {

      return arrDateTime.count
    }
//    switch section {
//    case FilterSections.keywords.rawValue:
//      return arrKeywords.count
//    case FilterSections.countries.rawValue:
//      return arrCountries.count
//    case FilterSections.dateTime.rawValue:
//      return arrDateTime.count
//    default:
//      return 0
//    }
  }
  func dataForRow(section: Int, row: Int) -> String {
    let filter = FilterSections.init(rawValue: section)
    switch filter {
    case .keywords:
      return arrKeywords[row]
    case .dateTime:
      return arrDateTime[row]
    case .countries:
      return arrCountries[row].title ?? ""
    default:
      return ""
    }
  }

  func cellViewModel(for row: Int) -> KeywordCellViewModel{
    let keyword = arrKeywords[row]
    let viewModel = KeywordCellViewModelImplementation(keyword: keyword)

    return viewModel
  }

  func cellViewModel(for row: Int) -> DateTimeCellViewModel{
    let dateTime = arrDateTime[row]
    let isSelected = selectedDateTime == row

    let viewModel = DateTimeCellViewModelImplementation(dateTime: dateTime, isSelected: isSelected)
    return viewModel
  }
  func cellViewModel(for row: Int) -> CountriesCellViewModel{
    let country = arrCountries[row].title ?? ""
    let isSelected = selectedCountry == country
    let viewModel = CountriesCellViewModelImplementation(country: country, isSelected: isSelected)
    return viewModel
  }
  func didDeleteKeyword(for row: Int) {
    arrKeywords.remove(at: row)
  }
  func heightForSectionHeader(section: Int, tag: Int) -> Int {
    if tag == 0 {
      if section == 0 {
        return 0
      }
      return 50
    }
    return 50
  }
  func title(forSection section: Int) -> String {
//    switch section {
//    case FilterSections.keywords.rawValue:
//      return ""
//    case FilterSections.countries.rawValue:
//      return "Countries"
//    case FilterSections.dateTime.rawValue:
//      return "Date & Time"
//    default:
//      return ""
//    }
    if section == 0 {
      return "Countries"
    }
    else {
      return "Date & Time"
    }
  }
////  func didSelectItem(for row: Int, section: Int){
////    if section == 0 {
////      // setup country selection
////    }
////    else {
////      selectedDateTime = row
////    }
//  }

  func sizeForItem(row: Int, section: Int, tag: Int) -> CGSize{
    let fontSize = DesignUtility.getFontSize(fSize: 24)

    if tag == 0 {
    if section == 0 {
      return CGSize(width: 10, height: 10)
    }
      else {
        let country = arrCountries[row].title ?? ""
        let size = country.size(withAttributes: [
          NSAttributedString.Key.font : UIFont(name: "Montserrat-SemiBold", size: fontSize)!
        ])
        let height = size.height + 10
        let width = size.width + 10
        return CGSize(width: width, height: height)
      }
    }
    else {
      let dateTime = arrDateTime[row]
      let size = dateTime.size(withAttributes: [
        NSAttributedString.Key.font : UIFont(name: "Montserrat-SemiBold", size: fontSize)!
      ])
      let height = size.height + 10
      let width = size.width + 10
      return CGSize(width: width, height: height)
    }
  }
  func getAllFilters() -> SelectedFilters{
    let selectedDate = selectedDateTime
    let selectedCountry = selectedCountry
    var keywords = arrKeywords.joined(separator: " ")
    if keywords != "" {
      keywords = keywords + " " + selectedCountry
    }
    else {
      keywords = selectedCountry
    }
    
    return (keywords, selectedDate)
  }
}

typealias SelectedFilters = (String, Int)
