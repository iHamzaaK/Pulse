//
//  SettingsTableViewCell.swift
//  Pulse
//
//  Created by Hamza Khan on 20/11/2020.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle : BaseUILabel!
    @IBOutlet weak var onOFFSwitch : UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
