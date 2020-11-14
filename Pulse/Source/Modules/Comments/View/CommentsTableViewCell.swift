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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
