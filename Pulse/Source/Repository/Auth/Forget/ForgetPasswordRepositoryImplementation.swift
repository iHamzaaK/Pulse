//
//  ForgetPasswordImplementation.swift
//  Pulse
//
//  Created by Hamza Khan on 01/12/2020.
//

import Foundation

class ForgetPasswordRepositoryImplementation : ForgetPasswordRepositoryProtocol{
  private let url = "wp/v2/sahifa/forgot_password_otp"
  private var isSuccess = false
  private var serverMsg = ""

  func resetPassword(email: String,completionHandler: @escaping (Bool, String) -> Void) {
    DispatchQueue.main.async{
      ActivityIndicator.shared.showSpinner(nil, title: nil)
    }
    let params = [
      "email": email
    ]
    let headers = [
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    ]

    BaseRepository.instance.requestService(url: url, method: .post, params: params, header: headers) { (success, serverMsg, data) in
      self.isSuccess = success
      self.serverMsg = serverMsg
      if self.isSuccess{
        guard let data = data else { return }
        let decoder = JSONDecoder()
        let model = try? decoder.decode(GeneralRepoModel.self, from: data.rawData())
        guard let statusCode = model?.statusCode else { return }
        self.isSuccess = statusCode != StatusCode.success.rawValue ? false : true
        guard let statusMsg = model?.message else { return }
        self.serverMsg = statusMsg
      }
      completionHandler(self.isSuccess, self.serverMsg)
    }
  }
}
