//
//  SearchTableViewCell.swift
//  Pulse
//
//  Created by Hamza Khan on 27/11/2020.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var lblSearchResult : BaseUILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
