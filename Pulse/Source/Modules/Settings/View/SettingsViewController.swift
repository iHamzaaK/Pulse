//
//  SettingsViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 20/11/2020.
//

import UIKit

class SettingsViewController: BaseViewController {

    var viewModel : SettingsViewModel!
    @IBOutlet weak var tblView: UITableView!{
        didSet{
            tblView.delegate = self
            tblView.dataSource = self
            tblView.estimatedRowHeight = 50
            tblView.rowHeight = UITableView.automaticDimension
            tblView.separatorStyle = .none
//            tblView.separatorColor = Utilities.hexStringToUIColor(hex: "CCCCCC")
            Utilities.registerNib(nibName: "QuotesTableViewCell", identifier: "QuotesTableViewCell", tblView: tblView)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarType = self.viewModel.getNavigationBar()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DesignUtility.convertToRatio(55, sizedForIPad:  DesignUtility.isIPad, sizedForNavi: false)
    }
}
