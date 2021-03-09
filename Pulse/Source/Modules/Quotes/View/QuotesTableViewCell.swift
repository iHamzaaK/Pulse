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
    var cellViewModel : QuoteCellViewModel!{
        didSet{
            lblQuotes.text = cellViewModel.quoteTitle
            lblAuthor.text = cellViewModel.getAuthor()
            lblDate.text = cellViewModel.timeStamp
        }
    }
//    @IBOutlet weak var containerView : BaseUIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor =  Utilities.hexStringToUIColor(hex: "E5E5E5")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
