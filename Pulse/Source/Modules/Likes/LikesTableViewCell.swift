//
//  LikesTableViewCell.swift
//  Pulse
//
//  Created by Hamza Khan on 02/12/2020.
//

import UIKit

class LikesTableViewCell: UITableViewCell {

    @IBOutlet weak var imgViewUserName: BaseUIImageView?
    @IBOutlet weak var lblUsername: BaseUILabel?
    @IBOutlet weak var widthConstraintImageView : BaseLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if DesignUtility.isIPad{
            widthConstraintImageView.constant = DesignUtility.convertToRatio(52, sizedForIPad: true, sizedForNavi: false)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
