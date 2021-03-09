//
//  SettingsTableViewCell.swift
//  Pulse
//
//  Created by Hamza Khan on 20/11/2020.
//

import UIKit
protocol SettingsProtocol : class{
    func didTurnOnOffSwitch(switchFlag : Bool)->Void
}
class SettingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle : BaseUILabel!
    @IBOutlet weak var onOFFSwitch : UISwitch!
    weak var delegate : SettingsProtocol!
    var switchFlag: Bool = false {
        didSet{               //This will fire everytime the value for switchFlag is set
            //print(switchFlag) //do something with the switchFlag variable
            delegate.didTurnOnOffSwitch(switchFlag: switchFlag)
        }
    }
    @IBAction func switchChanged(_ sender: Any) {
        if self.onOFFSwitch.isOn{
            switchFlag = true
        }else{
            switchFlag = false
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
