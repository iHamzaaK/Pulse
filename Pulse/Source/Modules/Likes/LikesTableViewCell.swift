//
//  LikesTableViewCell.swift
//  Pulse
//
//  Created by Hamza Khan on 02/12/2020.
//

import UIKit

final class LikesTableViewCell: UITableViewCell {
  @IBOutlet weak var imgViewUserName: BaseUIImageView!
  @IBOutlet weak var lblUsername: BaseUILabel?
  @IBOutlet weak var widthConstraintImageView : BaseLayoutConstraint!
  var cellViewModel : LikesCellViewModel!{
    didSet{
      self.lblUsername?.text = cellViewModel.name ?? ""
      setupThumbnailImage()
    }
  }
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }
  
  func setupThumbnailImage(){
    if let bgImageURL = cellViewModel.getImageURL() {
      Utilities.getImageFromURL(imgView: imgViewUserName, url: bgImageURL){ (_) in
        self.setNeedsLayout()
      }
    }
    else{
      self.imgViewUserName.image = UIImage.init(named: "placeholder")
    }
  }

}
