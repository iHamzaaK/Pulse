//
//  QuotesTableViewCell.swift
//  Pulse
//
//  Created by Hamza Khan on 15/11/2020.
//

import UIKit

final class QuotesTableViewCell: UITableViewCell {
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
  override func awakeFromNib() {
    super.awakeFromNib()
    self.contentView.backgroundColor =  Utilities.hexStringToUIColor(hex: "E5E5E5")
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}
