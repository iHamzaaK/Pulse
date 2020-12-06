//
//  CommentsTableViewCell.swift
//  Pulse
//
//  Created by Hamza Khan on 14/11/2020.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {

    @IBOutlet weak var imgViewUserName: BaseUIImageView?
    @IBOutlet weak var lblUsername: BaseUILabel?
    @IBOutlet weak var lblComment: BaseUILabel?
    @IBOutlet weak var lblTime: BaseUILabel?
    @IBOutlet weak var btnSeeAllComments : BaseUIButton?
    @IBOutlet weak var widthConstraintImageView : BaseLayoutConstraint?
    @IBOutlet weak var leadingConstraintImageView : BaseLayoutConstraint?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if DesignUtility.isIPad{
            widthConstraintImageView?.constant = DesignUtility.convertToRatio(53, sizedForIPad: true, sizedForNavi: false)
            leadingConstraintImageView?.constant = DesignUtility.convertToRatio(75  , sizedForIPad: true, sizedForNavi: false)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
