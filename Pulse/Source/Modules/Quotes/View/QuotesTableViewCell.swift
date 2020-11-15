//
//  QuotesTableViewCell.swift
//  Pulse
//
//  Created by Hamza Khan on 15/11/2020.
//

import UIKit

class QuotesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblQuotes : BaseUILabel!
    @IBOutlet weak var lblAuthor : BaseUILabel!
    @IBOutlet weak var lblDate : BaseUILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
