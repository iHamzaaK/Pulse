//
//  PolicyViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 17/12/2020.
//

import UIKit

final class PolicyViewController: BaseViewController {
  var viewModel : PolicyViewModel!
  @IBOutlet weak var lblPolicy : BaseUILabel!
  @IBOutlet weak var txtViewPolicy : BaseUITextView!

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }

}
extension PolicyViewController{
  func setupView(){
    self.lblPolicy.text = self.viewModel.getTitle()
    self.getData()
    navBarType = self.viewModel.getNavigationBar()
  }

  func getData(){
    self.viewModel.getPolicy { (success, serverMsg, content)  in
      guard let content = content else {
        Alert.showAlertWithAutoHide(
          title: ErrorDescription.errorTitle.rawValue,
          message: "Policy not available",
          autoHidetimer: 2.0,
          type: .error
        )
        
        AppRouter.pop()
        return

      }
      self.txtViewPolicy.attributedText = content
    }
  }
}
