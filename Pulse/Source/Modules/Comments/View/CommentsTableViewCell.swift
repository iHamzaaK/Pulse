//
//  CommentsTableViewCell.swift
//  Pulse
//
//  Created by Hamza Khan on 14/11/2020.
//

import UIKit

final class CommentsTableViewCell: UITableViewCell {
  @IBOutlet weak var imgViewUserName: BaseUIImageView?
  @IBOutlet weak var lblUsername: BaseUILabel?
  @IBOutlet weak var lblComment: BaseUILabel?
  @IBOutlet weak var lblTime: BaseUILabel?
  @IBOutlet weak var btnSeeAllComments : BaseUIButton?
  @IBOutlet weak var widthConstraintImageView : BaseLayoutConstraint?
  @IBOutlet weak var leadingConstraintImageView : BaseLayoutConstraint?
  var cellViewModel : CommentCellViewModel!{
    didSet{
      if let imageURL  = cellViewModel.getImageURL() {
        Utilities.getImageFromURL(imgView: imgViewUserName!, url: imageURL) { (_) in
          self.setNeedsLayout()
        }
      }
      lblUsername?.text = cellViewModel.author
      lblTime?.text = cellViewModel.timestamp
      lblComment?.text = cellViewModel.comment

    }
  }
  override func awakeFromNib() {
    super.awakeFromNib()
    self.selectionStyle = .none
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}
