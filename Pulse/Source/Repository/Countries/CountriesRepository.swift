//
//  CountriesRepository.swift
//  Pulse
//
//  Created by Hamza Khan on 11.03.22.
//

import Foundation
protocol CountriesRepository {
  func getCountries(completionHandler: @escaping ( _ success : Bool , _ serverMsg : String, _ country : [Country])->Void)
}

final class CountriesRepositoryImplementation : CountriesRepository{
  private let url = "wp/v2/sahifa/afet/countries"
  private var isSuccess = false
  private var serverMsg = ""
  func getCountries(completionHandler: @escaping ( _ success : Bool , _ serverMsg : String, _ country : [Country] )->Void){
    DispatchQueue.main.async{
      ActivityIndicator.shared.showSpinner(nil,title: nil)
    }
    let headers = [
      "Content-Type": "application/x-www-form-urlencoded"
    ]

    BaseRepository.instance.requestService(url: url , method: .get, params: nil, header: headers) { (success, serverMsg, data) in
      if success{
        guard let data = data else { return }
        let decoder = JSONDecoder()
        do {
          let model = try decoder.decode(Countries.self, from: data.rawData())
          guard let countries = model.data else {
            completionHandler(false, "Bad server request", [])
            return
          }
          self.isSuccess = success
          completionHandler(true, "", countries)
        }
        catch {
          completionHandler(false, "Bad server request", [])
        }
      }
      else{
        completionHandler(self.isSuccess, self.serverMsg, [])
      }
    }
  }
}
