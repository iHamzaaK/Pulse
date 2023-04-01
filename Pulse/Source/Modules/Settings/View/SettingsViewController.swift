//
//  SettingsViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 20/11/2020.
//

import UIKit

final class SettingsViewController: BaseViewController {
  var viewModel : SettingsViewModel!
  @IBOutlet weak var tblView: UITableView!{
    didSet{
      tblView.delegate = self
      tblView.dataSource = self
      tblView.estimatedRowHeight = 50
      tblView.rowHeight = UITableView.automaticDimension
      tblView.separatorStyle = .none
      Utilities.registerNib(nibName: "QuotesTableViewCell", identifier: "QuotesTableViewCell", tblView: tblView)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    navBarType = self.viewModel.getNavigationBar()
  }
}

extension SettingsViewController : UITableViewDelegate, UITableViewDataSource, SettingsProtocol{
  func didTurnOnOffSwitch(switchFlag: Bool) {
    self.viewModel.updateProfile(switchFlag: switchFlag) { (success, serverMsg) in
    }
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell") as! SettingsTableViewCell
    cell.lblTitle.text = "Push Notifications"
    cell.delegate = self
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return DesignUtility.convertToRatio(55, sizedForIPad:  DesignUtility.isIPad, sizedForNavi: false)
  }
}
