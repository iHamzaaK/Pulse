//
//  SettingsTableViewCell.swift
//  Pulse
//
//  Created by Hamza Khan on 20/11/2020.
//

import UIKit

protocol SettingsProtocol : AnyObject{
  func didTurnOnOffSwitch(switchFlag : Bool)->Void
}

final class SettingsTableViewCell: UITableViewCell {
  @IBOutlet weak var lblTitle : BaseUILabel!
  @IBOutlet weak var onOFFSwitch : UISwitch!
  @IBAction func switchChanged(_ sender: Any) {
    if self.onOFFSwitch.isOn{
      switchFlag = true
    }else{
      switchFlag = false
    }
  }

  weak var delegate : SettingsProtocol!
  var switchFlag: Bool = false {
    didSet{
      //This will fire everytime the value for switchFlag is set
      delegate.didTurnOnOffSwitch(switchFlag: switchFlag)
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}
